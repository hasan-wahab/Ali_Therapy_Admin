import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/refer_by_report_entity.dart';
import '../repositories/refer_by_report_repository.dart';

// ============================================================
// GET REFERBYREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch refer by report data.
// ============================================================

class GetReferByReportUseCase extends UseCase<ReferByReportEntity, NoParams> {
  final ReferByReportRepository repository;

  GetReferByReportUseCase(this.repository);

  @override
  ResultFuture<ReferByReportEntity> call(NoParams params) {
    return repository.getReferByReport();
  }
}
