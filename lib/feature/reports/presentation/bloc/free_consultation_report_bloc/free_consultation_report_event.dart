part of 'free_consultation_report_bloc.dart';

abstract class FreeConsultationReportEvent extends Equatable {
  const FreeConsultationReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class FreeConsultationReportStarted extends FreeConsultationReportEvent {
  const FreeConsultationReportStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class FreeConsultationReportRefreshed extends FreeConsultationReportEvent {
  const FreeConsultationReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class FreeConsultationReportLoadMore extends FreeConsultationReportEvent {
  const FreeConsultationReportLoadMore();
}

/// Search text changed (starts debounce).
class FreeConsultationReportSearchChanged extends FreeConsultationReportEvent {
  const FreeConsultationReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Debounced search ready → reload page 1.
class FreeConsultationReportSearchSubmitted
    extends FreeConsultationReportEvent {
  const FreeConsultationReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Apply filter button pressed → reload page 1 with new filters.
class FreeConsultationReportFiltersApplied extends FreeConsultationReportEvent {
  const FreeConsultationReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.consultantId,
    this.clinicId,
    this.perPage,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearConsultantId = false,
    this.clearClinicId = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? consultantId;
  final int? clinicId;
  final int? perPage;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearConsultantId;
  final bool clearClinicId;

  /// Reset all filters (keeps current search).
  final bool resetAll;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        consultantId,
        clinicId,
        perPage,
        clearFromDate,
        clearToDate,
        clearConsultantId,
        clearClinicId,
        resetAll,
      ];
}
