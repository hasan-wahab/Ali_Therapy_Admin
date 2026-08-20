part of 'receptionist_report_bloc.dart';

abstract class ReceptionistReportEvent extends Equatable {
  const ReceptionistReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class ReceptionistReportStarted extends ReceptionistReportEvent {
  const ReceptionistReportStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class ReceptionistReportRefreshed extends ReceptionistReportEvent {
  const ReceptionistReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class ReceptionistReportLoadMore extends ReceptionistReportEvent {
  const ReceptionistReportLoadMore();
}

/// Search text changed (starts debounce).
class ReceptionistReportSearchChanged extends ReceptionistReportEvent {
  const ReceptionistReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Debounced search ready → reload page 1.
class ReceptionistReportSearchSubmitted extends ReceptionistReportEvent {
  const ReceptionistReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Apply filter button pressed → reload page 1 with new filters.
class ReceptionistReportFiltersApplied extends ReceptionistReportEvent {
  const ReceptionistReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.receptionistId,
    this.clinicId,
    this.perPage,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearReceptionistId = false,
    this.clearClinicId = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? receptionistId;
  final int? clinicId;
  final int? perPage;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearReceptionistId;
  final bool clearClinicId;

  /// Reset all filters (keeps current search).
  final bool resetAll;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        receptionistId,
        clinicId,
        perPage,
        clearFromDate,
        clearToDate,
        clearReceptionistId,
        clearClinicId,
        resetAll,
      ];
}
