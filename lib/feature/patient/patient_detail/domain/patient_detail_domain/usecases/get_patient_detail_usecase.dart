import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/patient_detail_entity.dart';
import '../repositories/patient_detail_repository.dart';

// ============================================================
// GET PATIENT DETAIL USE CASE
// ------------------------------------------------------------
// One job: fetch Patient Full View for the given patient id.
// ============================================================

class GetPatientDetailParams {
  const GetPatientDetailParams({required this.patientId});

  final String patientId;
}

class GetPatientDetailUseCase
    extends UseCase<PatientDetailEntity, GetPatientDetailParams> {
  GetPatientDetailUseCase(this.repository);

  final PatientDetailRepository repository;

  @override
  ResultFuture<PatientDetailEntity> call(GetPatientDetailParams params) {
    return repository.getPatientDetail(patientId: params.patientId);
  }
}
