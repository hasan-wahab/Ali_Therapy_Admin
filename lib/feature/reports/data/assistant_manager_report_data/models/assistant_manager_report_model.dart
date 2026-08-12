import '../../../domain/assistant_manager_report_domain/entities/assistant_manager_report_entity.dart';

// ============================================================
// ASSISTANTMANAGERREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class AssistantManagerReportModel extends AssistantManagerReportEntity {
  const AssistantManagerReportModel({required super.id});

  factory AssistantManagerReportModel.fromJson(Map<String, dynamic> json) {
    return AssistantManagerReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  AssistantManagerReportEntity toEntity() => AssistantManagerReportEntity(id: id);
}
