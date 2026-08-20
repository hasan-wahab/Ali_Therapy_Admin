part of 'patient_dues_history_bloc.dart';

abstract class PatientDuesHistoryEvent extends Equatable {
  const PatientDuesHistoryEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened — fetch invoices for [patientId].
class PatientDuesHistoryStarted extends PatientDuesHistoryEvent {
  const PatientDuesHistoryStarted(this.patientId);

  final String patientId;

  @override
  List<Object?> get props => [patientId];
}

/// Pull-to-refresh.
class PatientDuesHistoryRefreshed extends PatientDuesHistoryEvent {
  const PatientDuesHistoryRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}
