part of 'assistant_manager_report_bloc.dart';

abstract class AssistantManagerReportState extends Equatable {
  const AssistantManagerReportState();

  @override
  List<Object?> get props => [];
}

class AssistantManagerReportInitial extends AssistantManagerReportState {
  const AssistantManagerReportInitial();
}

class AssistantManagerReportLoading extends AssistantManagerReportState {
  const AssistantManagerReportLoading();
}

/// API success — list ready (supports append / load-more).
class AssistantManagerReportLoaded extends AssistantManagerReportState {
  const AssistantManagerReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const AssistantManagerReportQuery(),
  });

  final List<AssistantManagerReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final AssistantManagerReportQuery query;

  bool get hasMore => currentPage < lastPage;

  AssistantManagerReportLoaded copyWith({
    List<AssistantManagerReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    AssistantManagerReportQuery? query,
  }) {
    return AssistantManagerReportLoaded(
      rows: rows ?? this.rows,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshingList: isRefreshingList ?? this.isRefreshingList,
      filterOptions: filterOptions ?? this.filterOptions,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
        rows,
        currentPage,
        lastPage,
        total,
        isLoadingMore,
        isRefreshingList,
        filterOptions,
        query,
      ];
}

class AssistantManagerReportError extends AssistantManagerReportState {
  const AssistantManagerReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const AssistantManagerReportQuery(),
  });

  final String title;
  final String message;
  final List<AssistantManagerReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final AssistantManagerReportQuery query;

  @override
  List<Object?> get props => [
        title,
        message,
        rows,
        currentPage,
        lastPage,
        total,
        filterOptions,
        query,
      ];
}
