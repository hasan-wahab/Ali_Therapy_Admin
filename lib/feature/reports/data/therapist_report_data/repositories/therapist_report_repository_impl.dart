import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/therapist_report_domain/entities/therapist_report_entity.dart';
import '../../../domain/therapist_report_domain/repositories/therapist_report_repository.dart';

// ============================================================
// THERAPISTREPORT REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class TherapistReportRepositoryImpl implements TherapistReportRepository {
  TherapistReportRepositoryImpl();

  @override
  ResultFuture<TherapistReportEntity> getTherapistReport() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('TherapistReport API not integrated yet.'),
    );
  }
}
