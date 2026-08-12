part of 'patient_registration_bloc.dart';

abstract class PatientRegistrationState extends Equatable {
  const PatientRegistrationState();

  @override
  List<Object?> get props => [];
}

class PatientRegistrationInitial extends PatientRegistrationState {
  const PatientRegistrationInitial();
}

class PatientRegistrationLoading extends PatientRegistrationState {
  const PatientRegistrationLoading();
}

class PatientRegistrationError extends PatientRegistrationState {
  final String message;

  const PatientRegistrationError(this.message);

  @override
  List<Object?> get props => [message];
}
