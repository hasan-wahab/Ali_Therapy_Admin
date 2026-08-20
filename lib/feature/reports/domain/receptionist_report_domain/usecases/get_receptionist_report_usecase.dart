import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/repositories/receptionist_report_repository.dart';

// ============================================================
// GET RECEPTIONIST REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated receptionist report rows.
// ============================================================

class GetReceptionistReportUseCase
    extends UseCase<ReceptionistReportPageEntity, ReceptionistReportQuery> {
  GetReceptionistReportUseCase(this.repository);

  final ReceptionistReportRepository repository;

  @override
  ResultFuture<ReceptionistReportPageEntity> call(
    ReceptionistReportQuery params,
  ) {
    return repository.getReceptionistReportPage(query: params);
  }
}
