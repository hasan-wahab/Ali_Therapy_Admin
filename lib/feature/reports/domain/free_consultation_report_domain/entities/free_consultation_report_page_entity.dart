import 'package:equatable/equatable.dart';

import 'free_consultation_report_entity.dart';

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
  });

  final List<FreeConsultationReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
