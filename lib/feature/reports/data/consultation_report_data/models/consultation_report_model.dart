import '../../../domain/consultation_report_domain/entities/consultation_report_entity.dart';

// ============================================================
// CONSULTATIONREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ConsultationReportModel extends ConsultationReportEntity {
  const ConsultationReportModel({required super.id});

  factory ConsultationReportModel.fromJson(Map<String, dynamic> json) {
    return ConsultationReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ConsultationReportEntity toEntity() => ConsultationReportEntity(id: id);
}
