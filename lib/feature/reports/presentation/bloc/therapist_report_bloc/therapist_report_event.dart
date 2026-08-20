part of 'therapist_report_bloc.dart';

abstract class TherapistReportEvent extends Equatable {
  const TherapistReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class TherapistReportStarted extends TherapistReportEvent {
  const TherapistReportStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class TherapistReportRefreshed extends TherapistReportEvent {
  const TherapistReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class TherapistReportLoadMore extends TherapistReportEvent {
  const TherapistReportLoadMore();
}

/// Search text changed (starts debounce).
class TherapistReportSearchChanged extends TherapistReportEvent {
  const TherapistReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Debounced search ready → reload page 1.
class TherapistReportSearchSubmitted extends TherapistReportEvent {
  const TherapistReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Apply filter button pressed → reload page 1 with new filters.
class TherapistReportFiltersApplied extends TherapistReportEvent {
  const TherapistReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.therapistId,
    this.clinicId,
    this.perPage,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearTherapistId = false,
    this.clearClinicId = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? therapistId;
  final int? clinicId;
  final int? perPage;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearTherapistId;
  final bool clearClinicId;

  /// Reset all filters (keeps current search).
  final bool resetAll;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        therapistId,
        clinicId,
        perPage,
        clearFromDate,
        clearToDate,
        clearTherapistId,
        clearClinicId,
        resetAll,
      ];
}
