part of 'patient_profile_bloc.dart';

abstract class PatientProfileEvent extends Equatable {
  const PatientProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class PatientProfileStarted extends PatientProfileEvent {
  const PatientProfileStarted();
}
