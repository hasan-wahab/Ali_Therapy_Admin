import '../../../domain/reconsultation_report_domain/entities/reconsultation_report_entity.dart';

// ============================================================
// RECONSULTATIONREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ReconsultationReportModel extends ReconsultationReportEntity {
  const ReconsultationReportModel({required super.id});

  factory ReconsultationReportModel.fromJson(Map<String, dynamic> json) {
    return ReconsultationReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ReconsultationReportEntity toEntity() => ReconsultationReportEntity(id: id);
}
