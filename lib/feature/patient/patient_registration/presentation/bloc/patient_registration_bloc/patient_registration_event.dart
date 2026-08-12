part of 'patient_registration_bloc.dart';

abstract class PatientRegistrationEvent extends Equatable {
  const PatientRegistrationEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class PatientRegistrationStarted extends PatientRegistrationEvent {
  const PatientRegistrationStarted();
}
