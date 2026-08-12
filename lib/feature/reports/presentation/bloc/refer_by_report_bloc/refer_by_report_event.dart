part of 'refer_by_report_bloc.dart';

abstract class ReferByReportEvent extends Equatable {
  const ReferByReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class ReferByReportStarted extends ReferByReportEvent {
  const ReferByReportStarted();
}
