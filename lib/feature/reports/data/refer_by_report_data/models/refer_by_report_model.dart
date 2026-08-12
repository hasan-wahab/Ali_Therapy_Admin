import '../../../domain/refer_by_report_domain/entities/refer_by_report_entity.dart';

// ============================================================
// REFERBYREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ReferByReportModel extends ReferByReportEntity {
  const ReferByReportModel({required super.id});

  factory ReferByReportModel.fromJson(Map<String, dynamic> json) {
    return ReferByReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ReferByReportEntity toEntity() => ReferByReportEntity(id: id);
}
