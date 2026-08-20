part of 'patient_report_bloc.dart';

abstract class PatientReportState extends Equatable {
  const PatientReportState();

  @override
  List<Object?> get props => [];
}

class PatientReportInitial extends PatientReportState {
  const PatientReportInitial();
}

class PatientReportLoading extends PatientReportState {
  const PatientReportLoading();
}

class PatientReportLoaded extends PatientReportState {
  const PatientReportLoaded({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.isLoadingMore = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const PatientReportQuery(),
  });

  final List<PatientReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final bool isLoadingMore;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final PatientReportQuery query;

  bool get hasMore => currentPage < lastPage;

  PatientReportLoaded copyWith({
    List<PatientReportEntity>? rows,
    int? currentPage,
    int? lastPage,
    int? total,
    bool? isLoadingMore,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    PatientReportQuery? query,
  }) {
    return PatientReportLoaded(
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

class PatientReportError extends PatientReportState {
  const PatientReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.currentPage = 0,
    this.lastPage = 0,
    this.total = 0,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const PatientReportQuery(),
  });

  final String title;
  final String message;
  final List<PatientReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReportFilterOptionsEntity filterOptions;
  final PatientReportQuery query;

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
