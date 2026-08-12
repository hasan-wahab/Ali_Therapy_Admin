import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/insurance_panel_report_domain/entities/insurance_panel_report_entity.dart';
import '../../../domain/insurance_panel_report_domain/repositories/insurance_panel_report_repository.dart';

// ============================================================
// INSURANCEPANELREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class InsurancePanelReportRepositoryImpl implements InsurancePanelReportRepository {
  InsurancePanelReportRepositoryImpl();

  @override
  ResultFuture<InsurancePanelReportEntity> getInsurancePanelReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('InsurancePanelReport API not integrated yet.'),
    );
  }
}
