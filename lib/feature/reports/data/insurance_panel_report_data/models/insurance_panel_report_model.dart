import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_result_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_summary_entity.dart';

// ============================================================
// INSURANCE PANEL REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one panel row from GET /api/admin/reports/insurance-panel
// ============================================================

class InsurancePanelReportModel extends InsurancePanelReportEntity {
  const InsurancePanelReportModel({
    required super.id,
    required super.panelName,
    required super.policyType,
    required super.totalInvoices,
    required super.consultationBilled,
    required super.packageBilled,
    required super.totalBilled,
    required super.totalCovered,
    required super.totalPaidCash,
    required super.outstandingBalance,
  });

  factory InsurancePanelReportModel.fromJson(Map<String, dynamic> json) {
    return InsurancePanelReportModel(
      id: json['id']?.toString() ?? '',
      panelName: _text(json['panel_name']),
      policyType: _text(json['policy_type']),
      totalInvoices: _toInt(json['total_invoices']),
      consultationBilled: _toDouble(json['consultation_billed']),
      packageBilled: _toDouble(json['package_billed']),
      totalBilled: _toDouble(json['total_billed']),
      totalCovered: _toDouble(json['total_covered']),
      totalPaidCash: _toDouble(json['total_paid_cash']),
      outstandingBalance: _toDouble(json['outstanding_balance']),
    );
  }

  static List<InsurancePanelReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map(
            (e) => InsurancePanelReportModel.fromJson(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList();

  InsurancePanelReportEntity toEntity() => InsurancePanelReportEntity(
        id: id,
        panelName: panelName,
        policyType: policyType,
        totalInvoices: totalInvoices,
        consultationBilled: consultationBilled,
        packageBilled: packageBilled,
        totalBilled: totalBilled,
        totalCovered: totalCovered,
        totalPaidCash: totalPaidCash,
        outstandingBalance: outstandingBalance,
      );
}

// ============================================================
// INSURANCE PANEL REPORT SUMMARY MODEL
// ============================================================

class InsurancePanelReportSummaryModel
    extends InsurancePanelReportSummaryEntity {
  const InsurancePanelReportSummaryModel({
    required super.totalInvoices,
    required super.consultationBilled,
    required super.packageBilled,
    required super.totalBilled,
    required super.totalCovered,
    required super.totalPaidCash,
    required super.outstandingBalance,
  });

  factory InsurancePanelReportSummaryModel.fromJson(Map<String, dynamic> json) {
    return InsurancePanelReportSummaryModel(
      totalInvoices: _toInt(json['total_invoices']),
      consultationBilled: _toDouble(json['consultation_billed']),
      packageBilled: _toDouble(json['package_billed']),
      totalBilled: _toDouble(json['total_billed']),
      totalCovered: _toDouble(json['total_covered']),
      totalPaidCash: _toDouble(json['total_paid_cash']),
      outstandingBalance: _toDouble(json['outstanding_balance']),
    );
  }

  InsurancePanelReportSummaryEntity toEntity() =>
      InsurancePanelReportSummaryEntity(
        totalInvoices: totalInvoices,
        consultationBilled: consultationBilled,
        packageBilled: packageBilled,
        totalBilled: totalBilled,
        totalCovered: totalCovered,
        totalPaidCash: totalPaidCash,
        outstandingBalance: outstandingBalance,
      );
}

// ============================================================
// INSURANCE PANEL REPORT RESULT MODEL
// ------------------------------------------------------------
// Wraps summary + data[] from the API.
// ============================================================

class InsurancePanelReportResultModel extends InsurancePanelReportResultEntity {
  const InsurancePanelReportResultModel({
    required super.summary,
    required super.panels,
  });

  factory InsurancePanelReportResultModel.fromParts({
    required Map<String, dynamic>? summaryJson,
    required List<dynamic> panelsJson,
  }) {
    return InsurancePanelReportResultModel(
      summary: InsurancePanelReportSummaryModel.fromJson(summaryJson ?? {}),
      panels: InsurancePanelReportModel.listFromJson(panelsJson),
    );
  }

  InsurancePanelReportResultEntity toEntity() => InsurancePanelReportResultEntity(
        summary: summary,
        panels: panels,
      );
}

String _text(dynamic value) {
  if (value == null) return '_';
  final text = value.toString().trim();
  return text.isEmpty ? '_' : text;
}

int _toInt(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}

double _toDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString()) ?? 0;
}
