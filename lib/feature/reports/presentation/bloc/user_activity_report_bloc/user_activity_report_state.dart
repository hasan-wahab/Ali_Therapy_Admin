part of 'user_activity_report_bloc.dart';

abstract class UserActivityReportState extends Equatable {
  const UserActivityReportState();

  @override
  List<Object?> get props => [];
}

class UserActivityReportInitial extends UserActivityReportState {
  const UserActivityReportInitial();
}

class UserActivityReportLoading extends UserActivityReportState {
  const UserActivityReportLoading();
}

class UserActivityReportLoaded extends UserActivityReportState {
  const UserActivityReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const UserActivityReportQuery(),
  });

  final List<UserActivityReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final UserActivityReportQuery query;

  bool get hasMore => currentPage < lastPage;

  UserActivityReportLoaded copyWith({
    List<UserActivityReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    UserActivityReportQuery? query,
  }) {
    return UserActivityReportLoaded(
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

class UserActivityReportError extends UserActivityReportState {
  const UserActivityReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const UserActivityReportQuery(),
  });

  final String title;
  final String message;
  final List<UserActivityReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final UserActivityReportQuery query;

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
