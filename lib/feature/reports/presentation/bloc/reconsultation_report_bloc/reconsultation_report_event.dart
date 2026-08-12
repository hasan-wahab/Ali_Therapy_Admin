part of 'reconsultation_report_bloc.dart';

abstract class ReconsultationReportEvent extends Equatable {
  const ReconsultationReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ReconsultationReportStarted extends ReconsultationReportEvent {
  const ReconsultationReportStarted();
}
