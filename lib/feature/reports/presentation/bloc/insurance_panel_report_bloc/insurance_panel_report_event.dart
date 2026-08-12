part of 'insurance_panel_report_bloc.dart';

abstract class InsurancePanelReportEvent extends Equatable {
  const InsurancePanelReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class InsurancePanelReportStarted extends InsurancePanelReportEvent {
  const InsurancePanelReportStarted();
}
