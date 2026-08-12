part of 'receptionist_report_bloc.dart';

abstract class ReceptionistReportState extends Equatable {
  const ReceptionistReportState();

  @override
  List<Object?> get props => [];
}

class ReceptionistReportInitial extends ReceptionistReportState {
  const ReceptionistReportInitial();
}

class ReceptionistReportLoading extends ReceptionistReportState {
  const ReceptionistReportLoading();
}

class ReceptionistReportError extends ReceptionistReportState {
  final String message;

  const ReceptionistReportError(this.message);

  @override
  List<Object?> get props => [message];
}
