import '../../../domain/patient_registration_domain/entities/patient_create_form_entity.dart';
import '../../../domain/patient_registration_domain/entities/update_patient_entity.dart';
import 'create_patient_model.dart';

// ============================================================
// UPDATE PATIENT MODEL (Data)
// ------------------------------------------------------------
// POST /api/admin/patients/{id}/update
// Same form fields as create — reuse that payload builder.
// ============================================================

class UpdatePatientModel extends UpdatePatientEntity {
  const UpdatePatientModel({required super.message});

  factory UpdatePatientModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return UpdatePatientModel(
      message: raw.isEmpty ? 'Patient updated successfully!' : raw,
    );
  }

  UpdatePatientEntity toEntity() => UpdatePatientEntity(message: message);

  /// JSON or multipart (when a new patient photo is chosen).
  static dynamic requestPayload({required PatientCreateFormEntity form}) {
    return CreatePatientModel.requestPayload(form: form);
  }
}
