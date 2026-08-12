import '../../../domain/insurance_panel_report_domain/entities/insurance_panel_report_entity.dart';

// ============================================================
// INSURANCEPANELREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class InsurancePanelReportModel extends InsurancePanelReportEntity {
  const InsurancePanelReportModel({required super.id});

  factory InsurancePanelReportModel.fromJson(Map<String, dynamic> json) {
    return InsurancePanelReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  InsurancePanelReportEntity toEntity() => InsurancePanelReportEntity(id: id);
}
