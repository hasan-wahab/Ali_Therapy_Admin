import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/delete_patient_entity.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/repositories/all_patients_repository.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// DELETE PATIENT USE CASE (Domain)
// ------------------------------------------------------------
// One job: DELETE /patients/{id}
// ============================================================

class DeletePatientUseCase
    extends UseCase<DeletePatientEntity, DeletePatientParams> {
  DeletePatientUseCase(this.repository);

  final AllPatientsRepository repository;

  @override
  ResultFuture<DeletePatientEntity> call(DeletePatientParams params) =>
      repository.deletePatient(patientId: params.patientId);
}

class DeletePatientParams extends Equatable {
  const DeletePatientParams({required this.patientId});

  final String patientId;

  @override
  List<Object?> get props => [patientId];
}
