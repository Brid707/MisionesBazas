using Gameplay;

namespace ViewModel.ViewModels
{
    public sealed partial class MatchBoardViewModel
    {
        public bool IsMissionAttemptFinished => IsMissionAttemptSucceeded || IsMissionAttemptFailed;

        public bool IsMissionAttemptSucceeded => _confirmedMatchSnapshot?.MissionEvaluation?.MissionAttemptStatus ==
            MissionAttemptEvaluationStatus.Succeeded;

        public bool IsMissionAttemptFailed => _confirmedMatchSnapshot?.MissionEvaluation?.MissionAttemptStatus ==
            MissionAttemptEvaluationStatus.Failed;

        public bool IsTrickTurnVisible => IsMissionPreparationComplete && !IsMissionAttemptFinished;

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
                    feedbackResourceKey = "MissionEvaluation_Error_" +
                        _confirmedMatchSnapshot.MissionEvaluation.MissionFailureReason;
                }
                return feedbackResourceKey;
            }
        }

        private string GetMatchFaultFeedback(MatchAccessFault matchAccessFault)
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
            if (_pendingRadioSubmission != null &&
                (matchAccessFault?.FailureCode == nameof(RadioCommunicationFailureReason.OperationUnavailable) ||
                    matchAccessFault?.FailureCode == nameof(RadioCommunicationFailureReason.RequestLimitReached)))
            {
                feedbackResourceKey = "Radio_Error_" + matchAccessFault.FailureCode;
            }
            if (HasPendingPreparation)
            {
                feedbackResourceKey = "MissionPreparation_Error_OperationUnavailable";
            }
            return feedbackResourceKey;
        }

        private void NotifyMissionEvaluationProperties()
        {
            OnPropertyChanged(nameof(IsMissionAttemptFinished));
            OnPropertyChanged(nameof(IsMissionAttemptSucceeded));
            OnPropertyChanged(nameof(IsMissionAttemptFailed));
            OnPropertyChanged(nameof(IsTrickTurnVisible));
            OnPropertyChanged(nameof(MissionEvaluationFeedbackResourceKey));
        }
    }
}
