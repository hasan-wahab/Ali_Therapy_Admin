part of 'patient_dues_bloc.dart';

abstract class PatientDuesEvent extends Equatable {
  const PatientDuesEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class PatientDuesStarted extends PatientDuesEvent {
  const PatientDuesStarted();
}
