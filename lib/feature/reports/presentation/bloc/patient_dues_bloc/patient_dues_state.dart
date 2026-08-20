part of 'patient_dues_bloc.dart';

abstract class PatientDuesState extends Equatable {
  const PatientDuesState();

  @override
  List<Object?> get props => [];
}

class PatientDuesInitial extends PatientDuesState {
  const PatientDuesInitial();
}

class PatientDuesLoading extends PatientDuesState {
  const PatientDuesLoading();
}

/// API success — list ready (supports append / load-more).
class PatientDuesLoaded extends PatientDuesState {
  const PatientDuesLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const PatientDuesQuery(),
  });

  final List<PatientDuesEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final PatientDuesQuery query;

  bool get hasMore => currentPage < lastPage;

  PatientDuesLoaded copyWith({
    List<PatientDuesEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    PatientDuesQuery? query,
  }) {
    return PatientDuesLoaded(
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

class PatientDuesError extends PatientDuesState {
  const PatientDuesError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const PatientDuesQuery(),
  });

  final String title;
  final String message;
  final List<PatientDuesEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final PatientDuesQuery query;

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
