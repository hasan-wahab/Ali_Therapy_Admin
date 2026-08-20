part of 'consultation_report_bloc.dart';

abstract class ConsultationReportState extends Equatable {
  const ConsultationReportState();

  @override
  List<Object?> get props => [];
}

class ConsultationReportInitial extends ConsultationReportState {
  const ConsultationReportInitial();
}

class ConsultationReportLoading extends ConsultationReportState {
  const ConsultationReportLoading();
}

/// API success — list ready (supports append / load-more).
class ConsultationReportLoaded extends ConsultationReportState {
  const ConsultationReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ConsultationReportQuery(),
  });

  final List<ConsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final ConsultationReportQuery query;

  bool get hasMore => currentPage < lastPage;

  ConsultationReportLoaded copyWith({
    List<ConsultationReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    ConsultationReportQuery? query,
  }) {
    return ConsultationReportLoaded(
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

class ConsultationReportError extends ConsultationReportState {
  const ConsultationReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ConsultationReportQuery(),
  });

  final String title;
  final String message;
  final List<ConsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final ConsultationReportQuery query;

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
