part of 'clinical_history_bloc.dart';

abstract class ClinicalHistoryEvent extends Equatable {
  const ClinicalHistoryEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ClinicalHistoryStarted extends ClinicalHistoryEvent {
  const ClinicalHistoryStarted();
}
