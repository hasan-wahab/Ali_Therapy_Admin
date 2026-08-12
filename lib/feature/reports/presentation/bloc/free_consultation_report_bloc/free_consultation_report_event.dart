part of 'free_consultation_report_bloc.dart';

abstract class FreeConsultationReportEvent extends Equatable {
  const FreeConsultationReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class FreeConsultationReportStarted extends FreeConsultationReportEvent {
  const FreeConsultationReportStarted();
}
