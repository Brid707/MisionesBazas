using System;
using System.Collections.Concurrent;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Application.Models;
using Application.Ports;
using TrickTakingMissions.Logging.Abstractions.Ports;

namespace Host.Gameplay
{
    /// <summary>Runs one scan timer and at most two transition workers; no callback runs under a match lock.</summary>
    internal sealed class MissionTransitionScheduler : IDisposable
    {
        private const int ShutdownWaitMilliseconds = 5000;
        private const string ScheduledWorkerFaultTemplate =
            "Mission transition worker failed. ExceptionType={ExceptionType}.";
        private readonly IMatchUseCase _matchUseCase;
        private readonly IMatchStateChangePublisher _publisher;
        private readonly ILoggerService _logger;
        private readonly CancellationTokenSource _shutdown = new CancellationTokenSource();
        private readonly ConcurrentDictionary<Guid, Task> _workers = new ConcurrentDictionary<Guid, Task>();
        private Timer _timer;
        private int _isScanning;
        private int _isDisposed;

        public MissionTransitionScheduler(IMatchUseCase matchUseCase, IMatchStateChangePublisher publisher,
            ILoggerService logger)
        {
            _matchUseCase = matchUseCase ?? throw new ArgumentNullException(nameof(matchUseCase));
            _publisher = publisher ?? throw new ArgumentNullException(nameof(publisher));
            _logger = logger ?? throw new ArgumentNullException(nameof(logger));
        }

        public void OnHostOpened(object sender, EventArgs eventArgs)
        {
            _timer = new Timer(OnTimerTick, null, 0, MissionTransitionPolicy.SchedulerIntervalMilliseconds);
        }

        public void OnHostStopped(object sender, EventArgs eventArgs)
        {
            Dispose();
        }

        private void OnTimerTick(object state)
        {
            if (!_shutdown.IsCancellationRequested && Interlocked.CompareExchange(ref _isScanning, 1, 0) == 0)
            {
                Task scan = Task.Run(ScanDueTransitions);
                scan.ContinueWith(OnScanCompleted, TaskScheduler.Default);
            }
        }

        private void ScanDueTransitions()
        {
            try
            {
                int availableWorkers = MissionTransitionPolicy.MaximumConcurrentPreparations - _workers.Count;
                foreach (MissionTransitionWork transitionWork in
                    _matchUseCase.TakeDueMissionTransitions(availableWorkers))
                {
                    StartWorker(transitionWork);
                }
            }
            finally
            {
                Interlocked.Exchange(ref _isScanning, 0);
            }
        }

        private void OnScanCompleted(Task scan)
        {
            if (scan.IsFaulted)
            {
                _logger.Error(ScheduledWorkerFaultTemplate, scan.Exception.GetBaseException().GetType().Name);
            }
        }

        private void StartWorker(MissionTransitionWork transitionWork)
        {
            if (_shutdown.IsCancellationRequested)
            {
                _matchUseCase.ReleaseMissionTransitionReservation(transitionWork, false);
            }
            var worker = new Task(() => ExecuteWorker(transitionWork));
            if (_workers.TryAdd(transitionWork.MissionTransitionScheduleId, worker))
            {
                worker.ContinueWith(completed => OnWorkerCompleted(completed, transitionWork), TaskScheduler.Default);
                worker.Start(TaskScheduler.Default);
            }
        }

        private void ExecuteWorker(MissionTransitionWork transitionWork)
        {
            MissionTransitionExecutionResult result =
                _matchUseCase.ExecuteScheduledMissionTransition(transitionWork, _shutdown.Token);
            if (result.HasStateChanged && !_shutdown.IsCancellationRequested)
            {
                _publisher.PublishMatchStateChange(result.LobbyCode, result.CommittedMatchStateVersion);
            }
        }

        private void OnWorkerCompleted(Task worker, MissionTransitionWork transitionWork)
        {
            try
            {
                if (worker.IsFaulted)
                {
                    _logger.Error(ScheduledWorkerFaultTemplate, worker.Exception.GetBaseException().GetType().Name);
                    _matchUseCase.ReleaseMissionTransitionReservation(transitionWork, true);
                }
                else if (worker.IsCanceled || _shutdown.IsCancellationRequested)
                {
                    _matchUseCase.ReleaseMissionTransitionReservation(transitionWork, false);
                }
            }
            finally
            {
                _workers.TryRemove(transitionWork.MissionTransitionScheduleId, out Task _);
            }
        }

        public void Dispose()
        {
            if (Interlocked.Exchange(ref _isDisposed, 1) == 0)
            {
                _shutdown.Cancel();
                _timer?.Dispose();
                try
                {
                    Task.WaitAll(_workers.Values.ToArray(), ShutdownWaitMilliseconds);
                }
                catch (AggregateException ex)
                {
                    _logger.Warning(ScheduledWorkerFaultTemplate, ex.GetBaseException().GetType().Name);
                }
            }
        }
    }
}
