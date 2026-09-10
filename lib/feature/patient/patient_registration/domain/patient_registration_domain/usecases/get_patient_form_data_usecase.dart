import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/patient_form_data_entity.dart';
import '../repositories/patient_registration_repository.dart';

// ============================================================
// GET PATIENT FORM DATA USE CASE
// ------------------------------------------------------------
// One job: load registration dropdown lists.
// ============================================================

class GetPatientFormDataUseCase
    extends UseCase<PatientFormDataEntity, NoParams> {
  GetPatientFormDataUseCase(this.repository);

  final PatientRegistrationRepository repository;

  @override
  ResultFuture<PatientFormDataEntity> call(NoParams params) {
    return repository.getFormData();
  }
}
