part of 'user_activity_report_bloc.dart';

abstract class UserActivityReportEvent extends Equatable {
  const UserActivityReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class UserActivityReportStarted extends UserActivityReportEvent {
  const UserActivityReportStarted();
}
