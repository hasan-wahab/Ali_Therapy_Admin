import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

import '../entities/patient_create_form_entity.dart';
import '../entities/update_patient_entity.dart';
import '../repositories/patient_registration_repository.dart';

// ============================================================
// UPDATE PATIENT USE CASE
// ------------------------------------------------------------
// One job: POST /patients/{id}/update
// ============================================================

class UpdatePatientUseCase
    extends UseCase<UpdatePatientEntity, UpdatePatientParams> {
  UpdatePatientUseCase(this.repository);

  final PatientRegistrationRepository repository;

  @override
  ResultFuture<UpdatePatientEntity> call(UpdatePatientParams params) {
    return repository.updatePatient(
      patientId: params.patientId,
      form: params.form,
    );
  }
}

class UpdatePatientParams extends Equatable {
  const UpdatePatientParams({
    required this.patientId,
    required this.form,
  });

  final String patientId;
  final PatientCreateFormEntity form;

  @override
  List<Object?> get props => [patientId, form];
}
