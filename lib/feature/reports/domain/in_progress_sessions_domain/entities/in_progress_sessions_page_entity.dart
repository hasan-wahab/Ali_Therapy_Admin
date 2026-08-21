import 'package:equatable/equatable.dart';

import 'in_progress_sessions_entity.dart';

// ============================================================
// IN-PROGRESS SESSIONS PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of in-progress session rows.
// ============================================================

class InProgressSessionsPageEntity extends Equatable {
  const InProgressSessionsPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<InProgressSessionsEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
