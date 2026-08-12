part of 'assistant_manager_report_bloc.dart';

abstract class AssistantManagerReportEvent extends Equatable {
  const AssistantManagerReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class AssistantManagerReportStarted extends AssistantManagerReportEvent {
  const AssistantManagerReportStarted();
}
