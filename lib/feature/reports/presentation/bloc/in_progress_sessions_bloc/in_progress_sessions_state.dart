part of 'in_progress_sessions_bloc.dart';

abstract class InProgressSessionsState extends Equatable {
  const InProgressSessionsState();

  @override
  List<Object?> get props => [];
}

class InProgressSessionsInitial extends InProgressSessionsState {
  const InProgressSessionsInitial();
}

class InProgressSessionsLoading extends InProgressSessionsState {
  const InProgressSessionsLoading();
}

class InProgressSessionsLoaded extends InProgressSessionsState {
  const InProgressSessionsLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const InProgressSessionsQuery(),
  });

  final List<InProgressSessionsEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final InProgressSessionsQuery query;

  bool get hasMore => currentPage < lastPage;

  InProgressSessionsLoaded copyWith({
    List<InProgressSessionsEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    InProgressSessionsQuery? query,
  }) {
    return InProgressSessionsLoaded(
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

class InProgressSessionsError extends InProgressSessionsState {
  const InProgressSessionsError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const InProgressSessionsQuery(),
  });

  final String title;
  final String message;
  final List<InProgressSessionsEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final InProgressSessionsQuery query;

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
