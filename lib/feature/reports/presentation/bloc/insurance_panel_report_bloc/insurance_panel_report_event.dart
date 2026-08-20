part of 'insurance_panel_report_bloc.dart';

abstract class InsurancePanelReportEvent extends Equatable {
  const InsurancePanelReportEvent();

  @override
  List<Object?> get props => [];
}

class InsurancePanelReportStarted extends InsurancePanelReportEvent {
  const InsurancePanelReportStarted();
}

class InsurancePanelReportRefreshed extends InsurancePanelReportEvent {
  const InsurancePanelReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

class InsurancePanelReportSearchChanged extends InsurancePanelReportEvent {
  const InsurancePanelReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class InsurancePanelReportSearchSubmitted extends InsurancePanelReportEvent {
  const InsurancePanelReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class InsurancePanelReportFiltersApplied extends InsurancePanelReportEvent {
  const InsurancePanelReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearClinicId = false,
    this.clearReceptionistId = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearClinicId;
  final bool clearReceptionistId;
  final bool resetAll;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        clinicId,
        receptionistId,
        clearFromDate,
        clearToDate,
        clearClinicId,
        clearReceptionistId,
        resetAll,
      ];
}

class InsurancePanelReportTotalsToggled extends InsurancePanelReportEvent {
  const InsurancePanelReportTotalsToggled();
}
