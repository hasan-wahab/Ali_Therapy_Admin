import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_query.dart';

// ============================================================
// PATIENT DUES REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class PatientDuesRepository {
  ResultFuture<PatientDuesPageEntity> getPatientDuesPage({
    required PatientDuesQuery query,
  });
}
