using Gameplay;
using ViewModel.Base;

namespace ViewModel.ViewModels
{
    public sealed class MatchEvaluationViewModel : ViewModelBase
    {
        private MissionAttemptEvaluationStatus? _status;
        private string _failureReason;
        private bool _isPreparationComplete;

        public bool IsMissionAttemptFinished => IsMissionAttemptSucceeded || IsMissionAttemptFailed;

        public bool IsMissionAttemptSucceeded => _status == MissionAttemptEvaluationStatus.Succeeded;

        public bool IsMissionAttemptFailed => _status == MissionAttemptEvaluationStatus.Failed;

        public bool IsTrickTurnVisible => _isPreparationComplete && !IsMissionAttemptFinished;

        public string MissionEvaluationFeedbackResourceKey
        {
            get
            {
                string feedbackResourceKey = "MissionEvaluation_Label_InProgress";
                if (IsMissionAttemptSucceeded)
                {
                    feedbackResourceKey = "MissionEvaluation_Label_Succeeded";
                }
                else if (IsMissionAttemptFailed)
                {
                    feedbackResourceKey = "MissionEvaluation_Error_" + _failureReason;
                }
                return feedbackResourceKey;
            }
        }

        public void ApplyEvaluation(MissionEvaluationSnapshot evaluation, bool isPreparationComplete)
        {
            _status = evaluation?.MissionAttemptStatus;
            _failureReason = evaluation?.MissionFailureReason != null
                ? evaluation.MissionFailureReason.ToString()
                : null;
            _isPreparationComplete = isPreparationComplete;
            NotifyMissionEvaluationProperties();
        }

        public string GetMatchFaultFeedback(MatchAccessFault matchAccessFault, bool hasPendingRadio, bool hasPendingPreparation)
        {
            string feedbackResourceKey = "Match_AccessUnavailable";
            if (matchAccessFault?.FailureCode == nameof(MissionObjectiveDraftRejectionReason.RequestLimitReached))
            {
                feedbackResourceKey = "MissionDraft_Error_RequestLimitReached";
            }
            else if (matchAccessFault?.FailureCode == "MissionEvaluationUnavailable")
            {
                feedbackResourceKey = "MissionEvaluation_Error_Unavailable";
            }
            if (matchAccessFault?.FailureCode == "MissionRetryPreparationUnavailable")
            {
                feedbackResourceKey = "MissionRetry_Error_PreparationUnavailable";
            }
            if (hasPendingRadio &&
                (matchAccessFault?.FailureCode == nameof(RadioCommunicationFailureReason.OperationUnavailable) ||
                    matchAccessFault?.FailureCode == nameof(RadioCommunicationFailureReason.RequestLimitReached)))
            {
                feedbackResourceKey = "Radio_Error_" + matchAccessFault.FailureCode;
            }
            if (hasPendingPreparation)
            {
                feedbackResourceKey = "MissionPreparation_Error_OperationUnavailable";
            }
            return feedbackResourceKey;
        }

        public void NotifyMissionEvaluationProperties()
        {
            OnPropertyChanged(nameof(IsMissionAttemptFinished));
            OnPropertyChanged(nameof(IsMissionAttemptSucceeded));
            OnPropertyChanged(nameof(IsMissionAttemptFailed));
            OnPropertyChanged(nameof(IsTrickTurnVisible));
            OnPropertyChanged(nameof(MissionEvaluationFeedbackResourceKey));
        }
    }
}
