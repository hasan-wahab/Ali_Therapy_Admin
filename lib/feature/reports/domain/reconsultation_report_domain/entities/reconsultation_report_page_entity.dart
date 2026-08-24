import 'package:equatable/equatable.dart';

import 'reconsultation_report_entity.dart';
import 'reconsultation_report_summary_entity.dart';

// ============================================================
// RECONSULTATION REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of reconsultation report rows.
// ============================================================

class ReconsultationReportPageEntity extends Equatable {
  const ReconsultationReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.summary = const ReconsultationReportSummaryEntity.empty(),
  });

  final List<ReconsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final ReconsultationReportSummaryEntity summary;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total, summary];
}
