import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/repositories/refer_by_report_repository.dart';

// ============================================================
// GET REFER BY REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch refer-by report rows.
// ============================================================

class GetReferByReportUseCase
    extends UseCase<List<ReferByReportEntity>, ReferByReportQuery> {
  GetReferByReportUseCase(this.repository);

  final ReferByReportRepository repository;

  @override
  ResultFuture<List<ReferByReportEntity>> call(ReferByReportQuery params) {
    return repository.getReferByReport(query: params);
  }
}
