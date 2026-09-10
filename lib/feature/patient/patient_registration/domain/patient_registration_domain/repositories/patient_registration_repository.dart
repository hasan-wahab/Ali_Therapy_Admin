import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/create_patient_entity.dart';
import '../entities/patient_create_form_entity.dart';
import '../entities/patient_form_data_entity.dart';

// ============================================================
// PATIENT REGISTRATION REPOSITORY CONTRACT (Domain)
// ------------------------------------------------------------
// Domain only knows WHAT we need — not HOW (no Dio here).
// ============================================================

abstract class PatientRegistrationRepository {
  /// GET patients/form-data — dropdown lists for the form.
  ResultFuture<PatientFormDataEntity> getFormData();

  /// GET patient/{id} — existing values for Edit.
  ResultFuture<PatientCreateFormEntity> getPatientDetails({
    required String patientId,
  });

  /// POST patients/create
  ResultFuture<CreatePatientEntity> createPatient({
    required PatientCreateFormEntity form,
  });
}
