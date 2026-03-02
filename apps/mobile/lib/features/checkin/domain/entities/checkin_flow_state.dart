import 'package:mobile/features/checkin/domain/entities/checkin_draft.dart';

class CheckinFlowState {
  const CheckinFlowState({
    required this.stepIndex,
    required this.optimisticCompleted,
    required this.draft,
  });

  final int stepIndex;
  final bool optimisticCompleted;
  final CheckinDraft draft;

  CheckinFlowState copyWith({
    int? stepIndex,
    bool? optimisticCompleted,
    CheckinDraft? draft,
  }) {
    return CheckinFlowState(
      stepIndex: stepIndex ?? this.stepIndex,
      optimisticCompleted: optimisticCompleted ?? this.optimisticCompleted,
      draft: draft ?? this.draft,
    );
  }
}
