part of 'report_filter_options_bloc.dart';

abstract class ReportFilterOptionsState extends Equatable {
  const ReportFilterOptionsState();

  @override
  List<Object?> get props => [];
}

class ReportFilterOptionsInitial extends ReportFilterOptionsState {
  const ReportFilterOptionsInitial();
}

class ReportFilterOptionsLoading extends ReportFilterOptionsState {
  const ReportFilterOptionsLoading();
}

class ReportFilterOptionsLoaded extends ReportFilterOptionsState {
  const ReportFilterOptionsLoaded({required this.options});

  final ReportFilterOptionsEntity options;

  @override
  List<Object?> get props => [options];
}

class ReportFilterOptionsError extends ReportFilterOptionsState {
  const ReportFilterOptionsError({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];
}
