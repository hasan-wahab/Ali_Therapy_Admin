import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/receptionist_report_entity.dart';
import '../repositories/receptionist_report_repository.dart';

// ============================================================
// GET RECEPTIONISTREPORT USE CASE
// ------------------------------------------------------------
// One job: fetch receptionist report data.
// ============================================================

class GetReceptionistReportUseCase extends UseCase<ReceptionistReportEntity, NoParams> {
  final ReceptionistReportRepository repository;

  GetReceptionistReportUseCase(this.repository);

  @override
  ResultFuture<ReceptionistReportEntity> call(NoParams params) {
    return repository.getReceptionistReport();
  }
}
