import '../../../domain/all_patients_domain/entities/delete_patient_entity.dart';

// ============================================================
// DELETE PATIENT MODEL (Data)
// ------------------------------------------------------------
// Parses DELETE /patients/{id}:
// { "success": true, "message": "Patient and associated user..." }
// ============================================================

class DeletePatientModel extends DeletePatientEntity {
  const DeletePatientModel({required super.message});

  factory DeletePatientModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return DeletePatientModel(
      message: raw.isEmpty
          ? 'Patient and associated user account deleted successfully!'
          : raw,
    );
  }

  DeletePatientEntity toEntity() => DeletePatientEntity(message: message);
}
