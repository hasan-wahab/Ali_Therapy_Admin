import 'package:equatable/equatable.dart';

// ============================================================
// INSURANCE PANEL REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One panel row from GET /api/admin/reports/insurance-panel
// ============================================================

class InsurancePanelReportEntity extends Equatable {
  const InsurancePanelReportEntity({
    required this.id,
    required this.panelName,
    required this.policyType,
    required this.totalInvoices,
    required this.consultationBilled,
    required this.packageBilled,
    required this.totalBilled,
    required this.totalCovered,
    required this.totalPaidCash,
    required this.outstandingBalance,
  });

  final String id;
  final String panelName;
  final String policyType;
  final int totalInvoices;
  final double consultationBilled;
  final double packageBilled;
  final double totalBilled;
  final double totalCovered;
  final double totalPaidCash;
  final double outstandingBalance;

  @override
  List<Object?> get props => [
        id,
        panelName,
        policyType,
        totalInvoices,
        consultationBilled,
        packageBilled,
        totalBilled,
        totalCovered,
        totalPaidCash,
        outstandingBalance,
      ];
}
