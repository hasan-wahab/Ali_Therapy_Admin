import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/insurance_panel_report_entity.dart';
import '../repositories/insurance_panel_report_repository.dart';

// ============================================================
// GET INSURANCEPANELREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch insurance panel report data.
// ============================================================

class GetInsurancePanelReportUseCase extends UseCase<InsurancePanelReportEntity, NoParams> {
  final InsurancePanelReportRepository repository;

  GetInsurancePanelReportUseCase(this.repository);

  @override
  ResultFuture<InsurancePanelReportEntity> call(NoParams params) {
    return repository.getInsurancePanelReport();
  }
}
