part of 'insurance_panel_report_bloc.dart';

abstract class InsurancePanelReportState extends Equatable {
  const InsurancePanelReportState();

  @override
  List<Object?> get props => [];
}

class InsurancePanelReportInitial extends InsurancePanelReportState {
  const InsurancePanelReportInitial();
}

class InsurancePanelReportLoading extends InsurancePanelReportState {
  const InsurancePanelReportLoading();
}

class InsurancePanelReportError extends InsurancePanelReportState {
  final String message;

  const InsurancePanelReportError(this.message);

  @override
  List<Object?> get props => [message];
}
