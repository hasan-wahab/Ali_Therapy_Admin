part of 'patient_dues_bloc.dart';

abstract class PatientDuesState extends Equatable {
  const PatientDuesState();

  @override
  List<Object?> get props => [];
}

class PatientDuesInitial extends PatientDuesState {
  const PatientDuesInitial();
}

class PatientDuesLoading extends PatientDuesState {
  const PatientDuesLoading();
}

class PatientDuesError extends PatientDuesState {
  final String message;

  const PatientDuesError(this.message);

  @override
  List<Object?> get props => [message];
}
