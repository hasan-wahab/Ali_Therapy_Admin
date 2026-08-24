import 'package:equatable/equatable.dart';

import 'free_consultation_report_entity.dart';
import 'free_consultation_report_summary_entity.dart';

// ============================================================
// FREE CONSULTATION REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of free consultation report rows.
// ============================================================

class FreeConsultationReportPageEntity extends Equatable {
  const FreeConsultationReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.summary = const FreeConsultationReportSummaryEntity.empty(),
  });

  final List<FreeConsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final FreeConsultationReportSummaryEntity summary;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total, summary];
}
