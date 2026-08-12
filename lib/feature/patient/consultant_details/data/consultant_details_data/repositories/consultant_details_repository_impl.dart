import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../../../domain/consultant_details_domain/entities/consultant_details_entity.dart';
import '../../../domain/consultant_details_domain/repositories/consultant_details_repository.dart';

// ============================================================
// CONSULTANTDETAILS REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources when API work starts.
// Not registered in DI yet — UI stays sample-data only.
// ============================================================

class ConsultantDetailsRepositoryImpl implements ConsultantDetailsRepository {
  ConsultantDetailsRepositoryImpl();

  @override
  ResultFuture<ConsultantDetailsEntity> getConsultantDetails() async {
    // TODO: Wire remote data source + map model → entity.
    return Result.failure(
      const ServerFailure('ConsultantDetails API not integrated yet.'),
    );
  }
}
