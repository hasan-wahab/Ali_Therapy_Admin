import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/entities/patient_dues_history_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_history_domain/repositories/patient_dues_history_repository.dart';

// ============================================================
// GET PATIENT DUES HISTORY USE CASE
// ------------------------------------------------------------
// One job: fetch invoice rows for one patient.
// ============================================================

class GetPatientDuesHistoryUseCase
    extends UseCase<List<PatientDuesHistoryEntity>, String> {
  GetPatientDuesHistoryUseCase(this.repository);

  final PatientDuesHistoryRepository repository;

  @override
  ResultFuture<List<PatientDuesHistoryEntity>> call(String params) {
    return repository.getPatientDuesHistory(patientId: params);
  }
}
