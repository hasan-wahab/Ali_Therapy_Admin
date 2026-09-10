import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:equatable/equatable.dart';

import '../entities/patient_create_form_entity.dart';
import '../repositories/patient_registration_repository.dart';

// ============================================================
// GET PATIENT DETAILS USE CASE
// ------------------------------------------------------------
// One job: load one patient so Edit can prefill the form.
// ============================================================

class GetPatientDetailsUseCase
    extends UseCase<PatientCreateFormEntity, GetPatientDetailsParams> {
  GetPatientDetailsUseCase(this.repository);

  final PatientRegistrationRepository repository;

  @override
  ResultFuture<PatientCreateFormEntity> call(GetPatientDetailsParams params) {
    return repository.getPatientDetails(patientId: params.patientId);
  }
}

class GetPatientDetailsParams extends Equatable {
  const GetPatientDetailsParams({required this.patientId});

  final String patientId;

  @override
  List<Object?> get props => [patientId];
}
