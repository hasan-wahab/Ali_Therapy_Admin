part of 'patient_profile_bloc.dart';

abstract class PatientProfileState extends Equatable {
  const PatientProfileState();

  @override
  List<Object?> get props => [];
}

class PatientProfileInitial extends PatientProfileState {
  const PatientProfileInitial();
}

class PatientProfileLoading extends PatientProfileState {
  const PatientProfileLoading();
}

class PatientProfileError extends PatientProfileState {
  final String message;

  const PatientProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
