import 'package:equatable/equatable.dart';

import 'receptionist_report_entity.dart';

// ============================================================
// RECEPTIONIST REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of receptionist report rows.
// ============================================================

class ReceptionistReportPageEntity extends Equatable {
  const ReceptionistReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<ReceptionistReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
