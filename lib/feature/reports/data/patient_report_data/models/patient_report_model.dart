import '../../../domain/patient_report_domain/entities/patient_report_entity.dart';

// ============================================================
// PATIENTREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class PatientReportModel extends PatientReportEntity {
  const PatientReportModel({required super.id});

  factory PatientReportModel.fromJson(Map<String, dynamic> json) {
    return PatientReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  PatientReportEntity toEntity() => PatientReportEntity(id: id);
}
