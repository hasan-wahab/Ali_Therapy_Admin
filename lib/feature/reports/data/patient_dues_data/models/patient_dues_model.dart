import '../../../domain/patient_dues_domain/entities/patient_dues_entity.dart';

// ============================================================
// PATIENTDUES MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class PatientDuesModel extends PatientDuesEntity {
  const PatientDuesModel({required super.id});

  factory PatientDuesModel.fromJson(Map<String, dynamic> json) {
    return PatientDuesModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  PatientDuesEntity toEntity() => PatientDuesEntity(id: id);
}
