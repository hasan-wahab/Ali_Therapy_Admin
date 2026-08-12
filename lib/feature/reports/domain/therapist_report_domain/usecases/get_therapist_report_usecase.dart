import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/therapist_report_entity.dart';
import '../repositories/therapist_report_repository.dart';

// ============================================================
// GET THERAPISTREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch therapist report data.
// ============================================================

class GetTherapistReportUseCase extends UseCase<TherapistReportEntity, NoParams> {
  final TherapistReportRepository repository;

  GetTherapistReportUseCase(this.repository);

  @override
  ResultFuture<TherapistReportEntity> call(NoParams params) {
    return repository.getTherapistReport();
  }
}
