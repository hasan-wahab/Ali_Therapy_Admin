part of 'patient_report_bloc.dart';

abstract class PatientReportEvent extends Equatable {
  const PatientReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class PatientReportStarted extends PatientReportEvent {
  const PatientReportStarted();
}
