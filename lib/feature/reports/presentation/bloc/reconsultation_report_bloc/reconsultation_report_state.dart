part of 'reconsultation_report_bloc.dart';

abstract class ReconsultationReportState extends Equatable {
  const ReconsultationReportState();

  @override
  List<Object?> get props => [];
}

class ReconsultationReportInitial extends ReconsultationReportState {
  const ReconsultationReportInitial();
}

class ReconsultationReportLoading extends ReconsultationReportState {
  const ReconsultationReportLoading();
}

class ReconsultationReportError extends ReconsultationReportState {
  final String message;

  const ReconsultationReportError(this.message);

  @override
  List<Object?> get props => [message];
}
