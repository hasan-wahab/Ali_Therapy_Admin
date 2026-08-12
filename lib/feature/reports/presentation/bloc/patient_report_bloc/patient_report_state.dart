part of 'patient_report_bloc.dart';

abstract class PatientReportState extends Equatable {
  const PatientReportState();

  @override
  List<Object?> get props => [];
}

class PatientReportInitial extends PatientReportState {
  const PatientReportInitial();
}

class PatientReportLoading extends PatientReportState {
  const PatientReportLoading();
}

class PatientReportError extends PatientReportState {
  final String message;

  const PatientReportError(this.message);

  @override
  List<Object?> get props => [message];
}
