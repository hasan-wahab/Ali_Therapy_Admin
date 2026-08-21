import 'package:equatable/equatable.dart';

import 'discount_report_entity.dart';

// ============================================================
// DISCOUNT REPORT PAGE ENTITY (Domain)
// ------------------------------------------------------------
// One paginated page of discount report rows.
// ============================================================

class DiscountReportPageEntity extends Equatable {
  const DiscountReportPageEntity({
    required this.rows,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  final List<DiscountReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total];
}
