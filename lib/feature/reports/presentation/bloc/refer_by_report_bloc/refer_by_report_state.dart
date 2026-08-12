part of 'refer_by_report_bloc.dart';

abstract class ReferByReportState extends Equatable {
  const ReferByReportState();

  @override
  List<Object?> get props => [];
}

class ReferByReportInitial extends ReferByReportState {
  const ReferByReportInitial();
}

class ReferByReportLoading extends ReferByReportState {
  const ReferByReportLoading();
}

class ReferByReportError extends ReferByReportState {
  final String message;

  const ReferByReportError(this.message);

  @override
  List<Object?> get props => [message];
}
