import 'package:equatable/equatable.dart';

import 'therapist_report_entity.dart';

// ============================================================
// THERAPIST REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of therapist report rows.
// ============================================================

class TherapistReportPageEntity extends Equatable {
  const TherapistReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<TherapistReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
