import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_detail_entity.dart';
import '../repositories/patient_detail_repository.dart';

// ============================================================
// GET PATIENTDETAIL USE CASE
// ------------------------------------------------------------
// One job: fetch patient detail data.
// ============================================================

class GetPatientDetailUseCase extends UseCase<PatientDetailEntity, NoParams> {
  final PatientDetailRepository repository;

  GetPatientDetailUseCase(this.repository);

  @override
  ResultFuture<PatientDetailEntity> call(NoParams params) {
    return repository.getPatientDetail();
  }
}
