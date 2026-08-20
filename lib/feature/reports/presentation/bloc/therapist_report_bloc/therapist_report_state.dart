part of 'therapist_report_bloc.dart';

abstract class TherapistReportState extends Equatable {
  const TherapistReportState();

  @override
  List<Object?> get props => [];
}

class TherapistReportInitial extends TherapistReportState {
  const TherapistReportInitial();
}

class TherapistReportLoading extends TherapistReportState {
  const TherapistReportLoading();
}

/// API success — list ready (supports append / load-more).
class TherapistReportLoaded extends TherapistReportState {
  const TherapistReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const TherapistReportQuery(),
  });

  final List<TherapistReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final TherapistReportQuery query;

  bool get hasMore => currentPage < lastPage;

  TherapistReportLoaded copyWith({
    List<TherapistReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    TherapistReportQuery? query,
  }) {
    return TherapistReportLoaded(
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

class TherapistReportError extends TherapistReportState {
  const TherapistReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const TherapistReportQuery(),
  });

  final String title;
  final String message;
  final List<TherapistReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final TherapistReportQuery query;

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
