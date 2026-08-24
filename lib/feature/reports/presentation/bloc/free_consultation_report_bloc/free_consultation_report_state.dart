part of 'free_consultation_report_bloc.dart';

abstract class FreeConsultationReportState extends Equatable {
  const FreeConsultationReportState();

  @override
  List<Object?> get props => [];
}

class FreeConsultationReportInitial extends FreeConsultationReportState {
  const FreeConsultationReportInitial();
}

class FreeConsultationReportLoading extends FreeConsultationReportState {
  const FreeConsultationReportLoading();
}

/// API success — list ready (supports append / load-more).
class FreeConsultationReportLoaded extends FreeConsultationReportState {
  const FreeConsultationReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.summary = const FreeConsultationReportSummaryEntity.empty(),
    this.showStats = false,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const FreeConsultationReportQuery(),
  });

  final List<FreeConsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final FreeConsultationReportSummaryEntity summary;
  final bool showStats;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final FreeConsultationReportQuery query;

  bool get hasMore => currentPage < lastPage;

  FreeConsultationReportLoaded copyWith({
    List<FreeConsultationReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    FreeConsultationReportSummaryEntity? summary,
    bool? showStats,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    FreeConsultationReportQuery? query,
  }) {
    return FreeConsultationReportLoaded(
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

class FreeConsultationReportError extends FreeConsultationReportState {
  const FreeConsultationReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.summary = const FreeConsultationReportSummaryEntity.empty(),
    this.showStats = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const FreeConsultationReportQuery(),
  });

  final String title;
  final String message;
  final List<FreeConsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final FreeConsultationReportSummaryEntity summary;
  final bool showStats;
  final ReportFilterOptionsEntity filterOptions;
  final FreeConsultationReportQuery query;

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
