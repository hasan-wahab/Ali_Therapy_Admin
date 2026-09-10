import 'package:ali_therapy_admin/feature/patient/all_patients/data/all_patients_data/models/patients_page_model.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/patients_list_query.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/data/patient_detail_data/models/patient_detail_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/create_patient_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_edit_form_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_form_data_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_create_form_entity.dart';

// ============================================================
// PATIENTS REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// Lives in core/datasources/patients/
// Talks to the API. Throws AppException on errors.
// ============================================================

abstract class PatientsRemoteDataSource {
  /// GET patients?... (search + filters + page)
  Future<PatientsPageModel> getPatientsPage({
    required PatientsListQuery query,
  });

  /// GET patient/{id}/full-view
  Future<PatientDetailModel> getPatientFullView({
    required String patientId,
  });

  /// GET patient/{id} — one patient for Edit form
  Future<PatientEditFormModel> getPatientDetails({
    required String patientId,
  });

  /// GET patients/form-data — registration dropdowns
  Future<PatientFormDataModel> getPatientFormData();

  /// POST patients/create
  Future<CreatePatientModel> createPatient({
    required PatientCreateFormEntity form,
  });
}
