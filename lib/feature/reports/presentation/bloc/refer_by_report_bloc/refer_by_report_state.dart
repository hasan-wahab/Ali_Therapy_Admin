part of 'refer_by_report_bloc.dart';

abstract class ReferByReportState extends Equatable {
  const ReferByReportState();

  @override
  List<Object?> get props => [];
}

class ReferByReportInitial extends ReferByReportState {
  const ReferByReportInitial();
}

class ReferByReportLoading extends ReferByReportState {
  const ReferByReportLoading();
}

class ReferByReportLoaded extends ReferByReportState {
  const ReferByReportLoaded({
    required this.rows,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReferByReportQuery(),
  });

  final List<ReferByReportEntity> rows;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final ReferByReportQuery query;

  ReferByReportLoaded copyWith({
    List<ReferByReportEntity>? rows,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    ReferByReportQuery? query,
  }) {
    return ReferByReportLoaded(
      rows: rows ?? this.rows,
      isRefreshingList: isRefreshingList ?? this.isRefreshingList,
      filterOptions: filterOptions ?? this.filterOptions,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [rows, isRefreshingList, filterOptions, query];
}

class ReferByReportError extends ReferByReportState {
  const ReferByReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const ReferByReportQuery(),
  });

  final String title;
  final String message;
  final List<ReferByReportEntity> rows;
  final ReportFilterOptionsEntity filterOptions;
  final ReferByReportQuery query;

  @override
  List<Object?> get props => [title, message, rows, filterOptions, query];
}
