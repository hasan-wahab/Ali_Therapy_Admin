part of 'patient_report_bloc.dart';

abstract class PatientReportEvent extends Equatable {
  const PatientReportEvent();

  @override
  List<Object?> get props => [];
}

class PatientReportStarted extends PatientReportEvent {
  const PatientReportStarted();
}

class PatientReportRefreshed extends PatientReportEvent {
  const PatientReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

class PatientReportLoadMore extends PatientReportEvent {
  const PatientReportLoadMore();
}

class PatientReportSearchChanged extends PatientReportEvent {
  const PatientReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class PatientReportSearchSubmitted extends PatientReportEvent {
  const PatientReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class PatientReportFiltersApplied extends PatientReportEvent {
  const PatientReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.consultantId,
    this.therapistId,
    this.assistantManagerId,
    this.receptionistId,
    this.perPage,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearClinicId = false,
    this.clearConsultantId = false,
    this.clearTherapistId = false,
    this.clearAssistantManagerId = false,
    this.clearReceptionistId = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? clinicId;
  final int? consultantId;
  final int? therapistId;
  final int? assistantManagerId;
  final int? receptionistId;
  final int? perPage;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearClinicId;
  final bool clearConsultantId;
  final bool clearTherapistId;
  final bool clearAssistantManagerId;
  final bool clearReceptionistId;
  final bool resetAll;

  @override
  List<Object?> get props => [
    fromDate,
    toDate,
    clinicId,
    consultantId,
    therapistId,
    assistantManagerId,
    receptionistId,
    perPage,
    clearFromDate,
    clearToDate,
    clearClinicId,
    clearConsultantId,
    clearTherapistId,
    clearAssistantManagerId,
    clearReceptionistId,
    resetAll,
  ];
}
