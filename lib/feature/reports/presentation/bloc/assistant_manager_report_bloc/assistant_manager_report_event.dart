part of 'assistant_manager_report_bloc.dart';

abstract class AssistantManagerReportEvent extends Equatable {
  const AssistantManagerReportEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class AssistantManagerReportStarted extends AssistantManagerReportEvent {
  const AssistantManagerReportStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class AssistantManagerReportRefreshed extends AssistantManagerReportEvent {
  const AssistantManagerReportRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class AssistantManagerReportLoadMore extends AssistantManagerReportEvent {
  const AssistantManagerReportLoadMore();
}

/// Search text changed (starts debounce).
class AssistantManagerReportSearchChanged extends AssistantManagerReportEvent {
  const AssistantManagerReportSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Debounced search ready → reload page 1.
class AssistantManagerReportSearchSubmitted
    extends AssistantManagerReportEvent {
  const AssistantManagerReportSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Apply filter button pressed → reload page 1 with new filters.
class AssistantManagerReportFiltersApplied
    extends AssistantManagerReportEvent {
  const AssistantManagerReportFiltersApplied({
    this.fromDate,
    this.toDate,
    this.assistantManagerId,
    this.clinicId,
    this.perPage,
    this.clearFromDate = false,
    this.clearToDate = false,
    this.clearAssistantManagerId = false,
    this.clearClinicId = false,
    this.resetAll = false,
  });

  final String? fromDate;
  final String? toDate;
  final int? assistantManagerId;
  final int? clinicId;
  final int? perPage;

  final bool clearFromDate;
  final bool clearToDate;
  final bool clearAssistantManagerId;
  final bool clearClinicId;

  /// Reset all filters (keeps current search).
  final bool resetAll;

  @override
  List<Object?> get props => [
        fromDate,
        toDate,
        assistantManagerId,
        clinicId,
        perPage,
        clearFromDate,
        clearToDate,
        clearAssistantManagerId,
        clearClinicId,
        resetAll,
      ];
}
