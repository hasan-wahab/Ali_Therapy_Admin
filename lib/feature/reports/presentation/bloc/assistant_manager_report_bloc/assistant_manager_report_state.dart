part of 'assistant_manager_report_bloc.dart';

abstract class AssistantManagerReportState extends Equatable {
  const AssistantManagerReportState();

  @override
  List<Object?> get props => [];
}

class AssistantManagerReportInitial extends AssistantManagerReportState {
  const AssistantManagerReportInitial();
}

class AssistantManagerReportLoading extends AssistantManagerReportState {
  const AssistantManagerReportLoading();
}

class AssistantManagerReportError extends AssistantManagerReportState {
  final String message;

  const AssistantManagerReportError(this.message);

  @override
  List<Object?> get props => [message];
}
