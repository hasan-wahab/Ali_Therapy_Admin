part of 'consultation_report_bloc.dart';

abstract class ConsultationReportState extends Equatable {
  const ConsultationReportState();

  @override
  List<Object?> get props => [];
}

class ConsultationReportInitial extends ConsultationReportState {
  const ConsultationReportInitial();
}

class ConsultationReportLoading extends ConsultationReportState {
  const ConsultationReportLoading();
}

class ConsultationReportError extends ConsultationReportState {
  final String message;

  const ConsultationReportError(this.message);

  @override
  List<Object?> get props => [message];
}
