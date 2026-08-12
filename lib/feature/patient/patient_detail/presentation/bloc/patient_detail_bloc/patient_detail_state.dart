part of 'patient_detail_bloc.dart';

abstract class PatientDetailState extends Equatable {
  const PatientDetailState();

  @override
  List<Object?> get props => [];
}

class PatientDetailInitial extends PatientDetailState {
  const PatientDetailInitial();
}

class PatientDetailLoading extends PatientDetailState {
  const PatientDetailLoading();
}

class PatientDetailError extends PatientDetailState {
  final String message;

  const PatientDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
