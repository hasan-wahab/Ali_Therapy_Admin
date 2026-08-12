part of 'consultation_report_bloc.dart';

abstract class ConsultationReportEvent extends Equatable {
  const ConsultationReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ConsultationReportStarted extends ConsultationReportEvent {
  const ConsultationReportStarted();
}
