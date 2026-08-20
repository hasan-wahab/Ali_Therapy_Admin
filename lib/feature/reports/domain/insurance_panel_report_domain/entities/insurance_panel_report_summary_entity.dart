import 'package:equatable/equatable.dart';

// ============================================================
// INSURANCE PANEL REPORT SUMMARY ENTITY (Domain)
// ------------------------------------------------------------
// Totals object from GET /api/admin/reports/insurance-panel
// ============================================================

class InsurancePanelReportSummaryEntity extends Equatable {
  const InsurancePanelReportSummaryEntity({
    required this.totalInvoices,
    required this.consultationBilled,
    required this.packageBilled,
    required this.totalBilled,
    required this.totalCovered,
    required this.totalPaidCash,
    required this.outstandingBalance,
  });

  const InsurancePanelReportSummaryEntity.empty()
      : totalInvoices = 0,
        consultationBilled = 0,
        packageBilled = 0,
        totalBilled = 0,
        totalCovered = 0,
        totalPaidCash = 0,
        outstandingBalance = 0;

  final int totalInvoices;
  final double consultationBilled;
  final double packageBilled;
  final double totalBilled;
  final double totalCovered;
  final double totalPaidCash;
  final double outstandingBalance;

  @override
  List<Object?> get props => [
        totalInvoices,
        consultationBilled,
        packageBilled,
        totalBilled,
        totalCovered,
        totalPaidCash,
        outstandingBalance,
      ];
}
