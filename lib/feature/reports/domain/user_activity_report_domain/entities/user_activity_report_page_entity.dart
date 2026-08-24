import 'package:equatable/equatable.dart';

import 'user_activity_report_entity.dart';
import 'user_activity_report_summary_entity.dart';

// ============================================================
// USER ACTIVITY REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of user activity rows.
// ============================================================

class UserActivityReportPageEntity extends Equatable {
  const UserActivityReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
    this.summary = const UserActivityReportSummaryEntity.empty(),
  });

  final List<UserActivityReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final UserActivityReportSummaryEntity summary;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total, summary];
}
