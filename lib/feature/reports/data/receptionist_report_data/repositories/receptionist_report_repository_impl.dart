import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/receptionist_report_domain/entities/receptionist_report_entity.dart';
import '../../../domain/receptionist_report_domain/repositories/receptionist_report_repository.dart';

// ============================================================
// RECEPTIONISTREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ReceptionistReportRepositoryImpl implements ReceptionistReportRepository {
  ReceptionistReportRepositoryImpl();

  @override
  ResultFuture<ReceptionistReportEntity> getReceptionistReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('ReceptionistReport API not integrated yet.'),
    );
  }
}
