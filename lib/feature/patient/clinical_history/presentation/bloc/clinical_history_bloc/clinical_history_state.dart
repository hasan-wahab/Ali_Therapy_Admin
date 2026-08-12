part of 'clinical_history_bloc.dart';

abstract class ClinicalHistoryState extends Equatable {
  const ClinicalHistoryState();

  @override
  List<Object?> get props => [];
}

class ClinicalHistoryInitial extends ClinicalHistoryState {
  const ClinicalHistoryInitial();
}

class ClinicalHistoryLoading extends ClinicalHistoryState {
  const ClinicalHistoryLoading();
}

class ClinicalHistoryError extends ClinicalHistoryState {
  final String message;

  const ClinicalHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
