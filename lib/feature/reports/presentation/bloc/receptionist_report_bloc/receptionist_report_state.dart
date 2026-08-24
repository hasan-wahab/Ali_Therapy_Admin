part of 'receptionist_report_bloc.dart';

abstract class ReceptionistReportState extends Equatable {
  const ReceptionistReportState();

  @override
  List<Object?> get props => [];
}

class ReceptionistReportInitial extends ReceptionistReportState {
  const ReceptionistReportInitial();
}

class ReceptionistReportLoading extends ReceptionistReportState {
  const ReceptionistReportLoading();
}

/// API success — list ready (supports append / load-more).
class ReceptionistReportLoaded extends ReceptionistReportState {
  const ReceptionistReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.summary = const ReceptionistReportSummaryEntity.empty(),
    this.showStats = false,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReceptionistReportQuery(),
  });

  final List<ReceptionistReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReceptionistReportSummaryEntity summary;
  final bool showStats;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final ReceptionistReportQuery query;

  bool get hasMore => currentPage < lastPage;

  ReceptionistReportLoaded copyWith({
    List<ReceptionistReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    ReceptionistReportSummaryEntity? summary,
    bool? showStats,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    ReceptionistReportQuery? query,
  }) {
    return ReceptionistReportLoaded(
      rows: rows ?? this.rows,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      total: total ?? this.total,
      summary: summary ?? this.summary,
      showStats: showStats ?? this.showStats,
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
        summary,
        showStats,
        isLoadingMore,
        isRefreshingList,
        filterOptions,
        query,
      ];
}

class ReceptionistReportError extends ReceptionistReportState {
  const ReceptionistReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.summary = const ReceptionistReportSummaryEntity.empty(),
    this.showStats = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReceptionistReportQuery(),
  });

  final String title;
  final String message;
  final List<ReceptionistReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReceptionistReportSummaryEntity summary;
  final bool showStats;
  final ReportFilterOptionsEntity filterOptions;
  final ReceptionistReportQuery query;

  @override
  List<Object?> get props => [
        title,
        message,
        rows,
        currentPage,
        lastPage,
        total,
        summary,
        showStats,
        filterOptions,
        query,
      ];
}
