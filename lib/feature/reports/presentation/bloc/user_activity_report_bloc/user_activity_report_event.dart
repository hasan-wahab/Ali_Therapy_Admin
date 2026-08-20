part of 'user_activity_report_bloc.dart';

abstract class UserActivityReportEvent extends Equatable {
  const UserActivityReportEvent();

  @override
  List<Object?> get props => [];
}

class UserActivityReportStarted extends UserActivityReportEvent {
  const UserActivityReportStarted();
}

class UserActivityReportRefreshed extends UserActivityReportEvent {
  const UserActivityReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

class UserActivityReportLoadMore extends UserActivityReportEvent {
  const UserActivityReportLoadMore();
}

class UserActivityReportSearchChanged extends UserActivityReportEvent {
  const UserActivityReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class UserActivityReportSearchSubmitted extends UserActivityReportEvent {
  const UserActivityReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class UserActivityReportFiltersApplied extends UserActivityReportEvent {
  const UserActivityReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
    this.perPage,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearClinicId = false,
    this.clearReceptionistId = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;
  final int? perPage;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearClinicId;
  final bool clearReceptionistId;
  final bool resetAll;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        clinicId,
        receptionistId,
        perPage,
        clearFromDate,
        clearToDate,
        clearClinicId,
        clearReceptionistId,
        resetAll,
      ];
}
