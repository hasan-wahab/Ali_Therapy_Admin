part of 'patient_detail_bloc.dart';

abstract class PatientDetailEvent extends Equatable {
  const PatientDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Load Full View for the patient id from All Patients → View.
/// Pass [seed] to show already-loaded data (record screens) without a new API call.
class PatientDetailStarted extends PatientDetailEvent {
  const PatientDetailStarted({
    required this.patientId,
    this.seed,
  });

  final String patientId;
  final PatientDetailEntity? seed;

  @override
  List<Object?> get props => [patientId, seed];
}

/// Pull-to-refresh — reload Full View (same overlay as first load).
class PatientDetailRefreshed extends PatientDetailEvent {
  const PatientDetailRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}
