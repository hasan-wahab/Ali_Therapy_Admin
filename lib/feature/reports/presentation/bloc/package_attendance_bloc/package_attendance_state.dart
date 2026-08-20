part of 'package_attendance_bloc.dart';

abstract class PackageAttendanceState extends Equatable {
  const PackageAttendanceState();

  @override
  List<Object?> get props => [];
}

class PackageAttendanceInitial extends PackageAttendanceState {
  const PackageAttendanceInitial();
}

class PackageAttendanceLoading extends PackageAttendanceState {
  const PackageAttendanceLoading();
}

class PackageAttendanceLoaded extends PackageAttendanceState {
  const PackageAttendanceLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const PackageAttendanceQuery(),
  });

  final List<PackageAttendanceEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final PackageAttendanceQuery query;

  bool get hasMore => currentPage < lastPage;

  PackageAttendanceLoaded copyWith({
    List<PackageAttendanceEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    PackageAttendanceQuery? query,
  }) {
    return PackageAttendanceLoaded(
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

class PackageAttendanceError extends PackageAttendanceState {
  const PackageAttendanceError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const PackageAttendanceQuery(),
  });

  final String title;
  final String message;
  final List<PackageAttendanceEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final PackageAttendanceQuery query;

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
