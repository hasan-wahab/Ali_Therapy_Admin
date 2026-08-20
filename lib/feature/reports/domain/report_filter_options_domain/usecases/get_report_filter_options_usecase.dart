import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/report_filter_options_domain/repositories/report_filter_options_repository.dart';

// ============================================================
// GET REPORT FILTER OPTIONS USE CASE (Domain)
// ------------------------------------------------------------
// One job: fetch clinics, consultants, therapists,
// receptionists, assistant_managers, insurance_panels.
// ============================================================

class GetReportFilterOptionsUseCase
    extends UseCase<ReportFilterOptionsEntity, NoParams> {
  GetReportFilterOptionsUseCase(this.repository);

  final ReportFilterOptionsRepository repository;

  @override
  ResultFuture<ReportFilterOptionsEntity> call(NoParams params) =>
      repository.getFilterOptions();
}
