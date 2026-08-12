import '../../../domain/therapist_report_domain/entities/therapist_report_entity.dart';

// ============================================================
// THERAPISTREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class TherapistReportModel extends TherapistReportEntity {
  const TherapistReportModel({required super.id});

  factory TherapistReportModel.fromJson(Map<String, dynamic> json) {
    return TherapistReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  TherapistReportEntity toEntity() => TherapistReportEntity(id: id);
}
