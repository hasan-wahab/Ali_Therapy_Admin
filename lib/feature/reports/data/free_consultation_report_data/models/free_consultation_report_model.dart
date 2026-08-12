import '../../../domain/free_consultation_report_domain/entities/free_consultation_report_entity.dart';

// ============================================================
// FREECONSULTATIONREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class FreeConsultationReportModel extends FreeConsultationReportEntity {
  const FreeConsultationReportModel({required super.id});

  factory FreeConsultationReportModel.fromJson(Map<String, dynamic> json) {
    return FreeConsultationReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  FreeConsultationReportEntity toEntity() => FreeConsultationReportEntity(id: id);
}
