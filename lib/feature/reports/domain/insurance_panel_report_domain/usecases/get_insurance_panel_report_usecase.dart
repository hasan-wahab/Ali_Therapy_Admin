import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_result_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/repositories/insurance_panel_report_repository.dart';

// ============================================================
// GET INSURANCE PANEL REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch insurance panel report summary + rows.
// ============================================================

class GetInsurancePanelReportUseCase
    extends UseCase<InsurancePanelReportResultEntity, InsurancePanelReportQuery> {
  GetInsurancePanelReportUseCase(this.repository);

  final InsurancePanelReportRepository repository;

  @override
  ResultFuture<InsurancePanelReportResultEntity> call(
    InsurancePanelReportQuery params,
  ) {
    return repository.getInsurancePanelReport(query: params);
  }
}
