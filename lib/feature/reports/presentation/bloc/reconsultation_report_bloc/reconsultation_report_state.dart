part of 'reconsultation_report_bloc.dart';

abstract class ReconsultationReportState extends Equatable {
  const ReconsultationReportState();

  @override
  List<Object?> get props => [];
}

class ReconsultationReportInitial extends ReconsultationReportState {
  const ReconsultationReportInitial();
}

class ReconsultationReportLoading extends ReconsultationReportState {
  const ReconsultationReportLoading();
}

/// API success — list ready (supports append / load-more).
class ReconsultationReportLoaded extends ReconsultationReportState {
  const ReconsultationReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.summary = const ReconsultationReportSummaryEntity.empty(),
    this.showStats = false,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReconsultationReportQuery(),
  });

  final List<ReconsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReconsultationReportSummaryEntity summary;
  final bool showStats;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final ReconsultationReportQuery query;

  bool get hasMore => currentPage < lastPage;

  ReconsultationReportLoaded copyWith({
    List<ReconsultationReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    ReconsultationReportSummaryEntity? summary,
    bool? showStats,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    ReconsultationReportQuery? query,
  }) {
    return ReconsultationReportLoaded(
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

class ReconsultationReportError extends ReconsultationReportState {
  const ReconsultationReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.summary = const ReconsultationReportSummaryEntity.empty(),
    this.showStats = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReconsultationReportQuery(),
  });

  final String title;
  final String message;
  final List<ReconsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReconsultationReportSummaryEntity summary;
  final bool showStats;
  final ReportFilterOptionsEntity filterOptions;
  final ReconsultationReportQuery query;

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
