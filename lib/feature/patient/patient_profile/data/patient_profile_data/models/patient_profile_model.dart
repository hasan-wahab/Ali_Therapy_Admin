import '../../../domain/patient_profile_domain/entities/patient_profile_entity.dart';

// ============================================================
// PATIENTPROFILE MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class PatientProfileModel extends PatientProfileEntity {
  const PatientProfileModel({required super.id});

  factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
    return PatientProfileModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  PatientProfileEntity toEntity() => PatientProfileEntity(id: id);
}
