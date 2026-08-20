part of 'insurance_panel_report_bloc.dart';

abstract class InsurancePanelReportState extends Equatable {
  const InsurancePanelReportState();

  @override
  List<Object?> get props => [];
}

class InsurancePanelReportInitial extends InsurancePanelReportState {
  const InsurancePanelReportInitial();
}

class InsurancePanelReportLoading extends InsurancePanelReportState {
  const InsurancePanelReportLoading();
}

class InsurancePanelReportLoaded extends InsurancePanelReportState {
  const InsurancePanelReportLoaded({
    required this.rows,
    required this.summary,
    this.showTotals = false,
    this.isRefreshingList = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const InsurancePanelReportQuery(),
  });

  final List<InsurancePanelReportEntity> rows;
  final InsurancePanelReportSummaryEntity summary;
  final bool showTotals;
  final bool isRefreshingList;
  final ReportFilterOptionsEntity filterOptions;
  final InsurancePanelReportQuery query;

  InsurancePanelReportLoaded copyWith({
    List<InsurancePanelReportEntity>? rows,
    InsurancePanelReportSummaryEntity? summary,
    bool? showTotals,
    bool? isRefreshingList,
    ReportFilterOptionsEntity? filterOptions,
    InsurancePanelReportQuery? query,
  }) {
    return InsurancePanelReportLoaded(
      rows: rows ?? this.rows,
      summary: summary ?? this.summary,
      showTotals: showTotals ?? this.showTotals,
      isRefreshingList: isRefreshingList ?? this.isRefreshingList,
      filterOptions: filterOptions ?? this.filterOptions,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
        rows,
        summary,
        showTotals,
        isRefreshingList,
        filterOptions,
        query,
      ];
}

class InsurancePanelReportError extends InsurancePanelReportState {
  const InsurancePanelReportError({
    required this.title,
    required this.message,
    this.rows = const [],
    this.summary = const InsurancePanelReportSummaryEntity.empty(),
    this.showTotals = false,
    this.filterOptions = const ReportFilterOptionsEntity.empty(),
    this.query = const InsurancePanelReportQuery(),
  });

  final String title;
  final String message;
  final List<InsurancePanelReportEntity> rows;
  final InsurancePanelReportSummaryEntity summary;
  final bool showTotals;
  final ReportFilterOptionsEntity filterOptions;
  final InsurancePanelReportQuery query;

  @override
  List<Object?> get props => [
        title,
        message,
        rows,
        summary,
        showTotals,
        filterOptions,
        query,
      ];
}
