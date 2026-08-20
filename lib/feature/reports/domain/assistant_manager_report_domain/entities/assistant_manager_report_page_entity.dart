import 'package:equatable/equatable.dart';

import 'assistant_manager_report_entity.dart';

// ============================================================
// ASSISTANT MANAGER REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of assistant manager report rows.
// ============================================================

class AssistantManagerReportPageEntity extends Equatable {
  const AssistantManagerReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<AssistantManagerReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
