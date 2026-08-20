import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/repositories/therapist_report_repository.dart';

// ============================================================
// GET THERAPIST REPORT USE CASE
// ------------------------------------------------------------
// One job: fetch paginated therapist report rows.
// ============================================================

class GetTherapistReportUseCase
    extends UseCase<TherapistReportPageEntity, TherapistReportQuery> {
  GetTherapistReportUseCase(this.repository);

  final TherapistReportRepository repository;

  @override
  ResultFuture<TherapistReportPageEntity> call(TherapistReportQuery params) {
    return repository.getTherapistReportPage(query: params);
  }
}
