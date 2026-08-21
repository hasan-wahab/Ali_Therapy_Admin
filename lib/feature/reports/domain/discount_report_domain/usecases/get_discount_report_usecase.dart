import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/repositories/discount_report_repository.dart';

// ============================================================
// GET DISCOUNT REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated discount report rows.
// ============================================================

class GetDiscountReportUseCase
    extends UseCase<DiscountReportPageEntity, DiscountReportQuery> {
  GetDiscountReportUseCase(this.repository);

  final DiscountReportRepository repository;

  @override
  ResultFuture<DiscountReportPageEntity> call(DiscountReportQuery params) {
    return repository.getDiscountReportPage(query: params);
  }
}
