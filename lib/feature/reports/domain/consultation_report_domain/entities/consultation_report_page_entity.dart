import 'package:equatable/equatable.dart';

import 'consultation_report_entity.dart';

// ============================================================
// CONSULTATION REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of consultant report rows.
// ============================================================

class ConsultationReportPageEntity extends Equatable {
  const ConsultationReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<ConsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
