import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

import '../entities/create_patient_entity.dart';
import '../entities/patient_create_form_entity.dart';
import '../repositories/patient_registration_repository.dart';

// ============================================================
// CREATE PATIENT USE CASE
// ------------------------------------------------------------
// One job: POST /patients/create
// ============================================================

class CreatePatientUseCase
    extends UseCase<CreatePatientEntity, CreatePatientParams> {
  CreatePatientUseCase(this.repository);

  final PatientRegistrationRepository repository;

  @override
  ResultFuture<CreatePatientEntity> call(CreatePatientParams params) {
    return repository.createPatient(form: params.form);
  }
}

class CreatePatientParams extends Equatable {
  const CreatePatientParams({required this.form});

  final PatientCreateFormEntity form;

  @override
  List<Object?> get props => [form];
}
