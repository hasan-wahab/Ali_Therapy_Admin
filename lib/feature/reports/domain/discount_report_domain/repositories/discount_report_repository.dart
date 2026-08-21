import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';

// ============================================================
// DISCOUNT REPORT REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class DiscountReportRepository {
  ResultFuture<DiscountReportPageEntity> getDiscountReportPage({
    required DiscountReportQuery query,
  });
}
