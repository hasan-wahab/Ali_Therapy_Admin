part of 'in_progress_sessions_bloc.dart';

abstract class InProgressSessionsEvent extends Equatable {
  const InProgressSessionsEvent();

  @override
  List<Object?> get props => [];
}

class InProgressSessionsStarted extends InProgressSessionsEvent {
  const InProgressSessionsStarted();
}

class InProgressSessionsRefreshed extends InProgressSessionsEvent {
  const InProgressSessionsRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

class InProgressSessionsLoadMore extends InProgressSessionsEvent {
  const InProgressSessionsLoadMore();
}

class InProgressSessionsSearchChanged extends InProgressSessionsEvent {
  const InProgressSessionsSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class InProgressSessionsSearchSubmitted extends InProgressSessionsEvent {
  const InProgressSessionsSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

class InProgressSessionsFiltersApplied extends InProgressSessionsEvent {
  const InProgressSessionsFiltersApplied({
    this.sessionType,
    this.clinicId,
    this.staffId,
    this.fromDate,
    this.toDate,
    this.clearClinicId = false,
    this.clearStaffId = false,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.resetAll = false,
  });

  final String? sessionType;
  final int? clinicId;
  final int? staffId;
  final String? fromDate;
  final String? toDate;
  final bool clearClinicId;
  final bool clearStaffId;
  final bool clearFromDate;
  final bool clearToDate;
  final bool resetAll;

  @override
  List<Object?> get props => [
        sessionType,
        clinicId,
        staffId,
        fromDate,
        toDate,
        clearClinicId,
        clearStaffId,
        clearFromDate,
        clearToDate,
        resetAll,
      ];
}
