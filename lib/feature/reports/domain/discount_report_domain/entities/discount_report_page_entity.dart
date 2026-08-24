import 'package:equatable/equatable.dart';

import 'discount_report_entity.dart';
import 'discount_report_summary_entity.dart';

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
    this.summary = const DiscountReportSummaryEntity.empty(),
  });

  final List<DiscountReportEntity> rows;
  final int currentPage;
  final int lastPage;
  final int total;
  final DiscountReportSummaryEntity summary;

  bool get hasMore => currentPage < lastPage;

  @override
  List<Object?> get props => [rows, currentPage, lastPage, total, summary];
}
