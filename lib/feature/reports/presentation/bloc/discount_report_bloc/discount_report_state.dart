part of 'discount_report_bloc.dart';

abstract class DiscountReportState extends Equatable {
  const DiscountReportState();

  @override
  List<Object?> get props => [];
}

class DiscountReportInitial extends DiscountReportState {
  const DiscountReportInitial();
}

class DiscountReportLoading extends DiscountReportState {
  const DiscountReportLoading();
}

class DiscountReportLoaded extends DiscountReportState {
  const DiscountReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.summary = const DiscountReportSummaryEntity.empty(),
    this.showStats = false,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const DiscountReportQuery(),
  });

  final List<DiscountReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final DiscountReportSummaryEntity summary;
  final bool showStats;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final DiscountReportQuery query;

  bool get hasMore => currentPage < lastPage;

  DiscountReportLoaded copyWith({
    List<DiscountReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    DiscountReportSummaryEntity? summary,
    bool? showStats,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    DiscountReportQuery? query,
  }) {
    return DiscountReportLoaded(
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

class DiscountReportError extends DiscountReportState {
  const DiscountReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.summary = const DiscountReportSummaryEntity.empty(),
    this.showStats = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const DiscountReportQuery(),
  });

  final String title;
  final String message;
  final List<DiscountReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final DiscountReportSummaryEntity summary;
  final bool showStats;
  final ReportFilterOptionsEntity filterOptions;
  final DiscountReportQuery query;

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
