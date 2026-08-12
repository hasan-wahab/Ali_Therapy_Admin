import '../../../domain/receptionist_report_domain/entities/receptionist_report_entity.dart';

// ============================================================
// RECEPTIONISTREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class ReceptionistReportModel extends ReceptionistReportEntity {
  const ReceptionistReportModel({required super.id});

  factory ReceptionistReportModel.fromJson(Map<String, dynamic> json) {
    return ReceptionistReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  ReceptionistReportEntity toEntity() => ReceptionistReportEntity(id: id);
}
