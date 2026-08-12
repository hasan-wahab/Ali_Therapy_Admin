import '../../../domain/patient_detail_domain/entities/patient_detail_entity.dart';

// ============================================================
// PATIENTDETAIL MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class PatientDetailModel extends PatientDetailEntity {
  const PatientDetailModel({required super.id});

  factory PatientDetailModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  PatientDetailEntity toEntity() => PatientDetailEntity(id: id);
}
