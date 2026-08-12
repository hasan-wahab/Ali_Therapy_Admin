import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/reconsultation_report_entity.dart';
import '../repositories/reconsultation_report_repository.dart';

// ============================================================
// GET RECONSULTATIONREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch reconsultation report data.
// ============================================================

class GetReconsultationReportUseCase extends UseCase<ReconsultationReportEntity, NoParams> {
  final ReconsultationReportRepository repository;

  GetReconsultationReportUseCase(this.repository);

  @override
  ResultFuture<ReconsultationReportEntity> call(NoParams params) {
    return repository.getReconsultationReport();
  }
}
