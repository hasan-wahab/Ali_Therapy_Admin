import 'package:equatable/equatable.dart';

import 'discount_report_entity.dart';

// ============================================================
// DISCOUNT REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the discount report screen.
// ============================================================

class DiscountReportSummaryEntity extends Equatable {
  const DiscountReportSummaryEntity({
    required this.discountedInvoices,
    required this.totalGrossBilled,
    required this.totalDiscountGiven,
    required this.netBilledAmount,
  });

  const DiscountReportSummaryEntity.empty()
      : discountedInvoices = 0,
        totalGrossBilled = 0,
        totalDiscountGiven = 0,
        netBilledAmount = 0;

  final int discountedInvoices;
  final double totalGrossBilled;
  final double totalDiscountGiven;
  final double netBilledAmount;

  bool get isEmpty =>
      discountedInvoices == 0 &&
      totalGrossBilled == 0 &&
      totalDiscountGiven == 0 &&
      netBilledAmount == 0;

  /// Fallback when the API does not send a totals object.
  factory DiscountReportSummaryEntity.fromRows(
    List<DiscountReportEntity> rows, {
    int? invoiceCount,
  }) {
    var gross = 0.0;
    var discount = 0.0;
    var net = 0.0;
    for (final row in rows) {
      gross += row.grossAmount;
      discount += row.totalDiscount;
      net += row.netAmount;
    }
    return DiscountReportSummaryEntity(
      discountedInvoices: invoiceCount ?? rows.length,
      totalGrossBilled: gross,
      totalDiscountGiven: discount,
      netBilledAmount: net,
    );
  }

  @override
  List<Object?> get props => [
        discountedInvoices,
        totalGrossBilled,
        totalDiscountGiven,
        netBilledAmount,
      ];
}
