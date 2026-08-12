part of 'free_consultation_report_bloc.dart';

abstract class FreeConsultationReportState extends Equatable {
  const FreeConsultationReportState();

  @override
  List<Object?> get props => [];
}

class FreeConsultationReportInitial extends FreeConsultationReportState {
  const FreeConsultationReportInitial();
}

class FreeConsultationReportLoading extends FreeConsultationReportState {
  const FreeConsultationReportLoading();
}

class FreeConsultationReportError extends FreeConsultationReportState {
  final String message;

  const FreeConsultationReportError(this.message);

  @override
  List<Object?> get props => [message];
}
