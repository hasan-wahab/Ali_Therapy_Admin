import '../../../domain/patient_registration_domain/entities/patient_registration_entity.dart';

// ============================================================
// PATIENTREGISTRATION MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class PatientRegistrationModel extends PatientRegistrationEntity {
  const PatientRegistrationModel({required super.id});

  factory PatientRegistrationModel.fromJson(Map<String, dynamic> json) {
    return PatientRegistrationModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  PatientRegistrationEntity toEntity() => PatientRegistrationEntity(id: id);
}
