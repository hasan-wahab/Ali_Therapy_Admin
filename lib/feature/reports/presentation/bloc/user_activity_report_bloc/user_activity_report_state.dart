part of 'user_activity_report_bloc.dart';

abstract class UserActivityReportState extends Equatable {
  const UserActivityReportState();

  @override
  List<Object?> get props => [];
}

class UserActivityReportInitial extends UserActivityReportState {
  const UserActivityReportInitial();
}

class UserActivityReportLoading extends UserActivityReportState {
  const UserActivityReportLoading();
}

class UserActivityReportError extends UserActivityReportState {
  final String message;

  const UserActivityReportError(this.message);

  @override
  List<Object?> get props => [message];
}
