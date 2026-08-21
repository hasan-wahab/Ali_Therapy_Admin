import 'package:equatable/equatable.dart';

// ============================================================
// DISCOUNT REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/discount
// ============================================================

class DiscountReportEntity extends Equatable {
  const DiscountReportEntity({
    required this.id,
    required this.patientName,
    required this.patientCnic,
    required this.patientPhone,
    required this.consultantName,
    required this.clinicName,
    required this.receptionistName,
    required this.grossAmount,
    required this.discount,
    required this.insuranceDiscount,
    required this.totalDiscount,
    required this.netAmount,
    required this.paidAmount,
    required this.remainingAmount,
  });

  final String id;
  final String patientName;
  final String patientCnic;
  final String patientPhone;
  final String consultantName;
  final String clinicName;
  final String receptionistName;
  final double grossAmount;
  final double discount;
  final double insuranceDiscount;
  final double totalDiscount;
  final double netAmount;
  final double paidAmount;
  final double remainingAmount;

  /// Percent off from total discount vs gross billed.
  int get discountPercent {
    if (grossAmount <= 0) return 0;
    return ((totalDiscount / grossAmount) * 100).round();
  }

  /// Payment badge from remaining / paid amounts.
  String get paymentStatus {
    if (remainingAmount <= 0.009) return 'Fully Paid';
    if (paidAmount <= 0.009) return 'Unpaid';
    return 'Partially Paid';
  }

  @override
  List<Object?> get props => [
        id,
        patientName,
        patientCnic,
        patientPhone,
        consultantName,
        clinicName,
        receptionistName,
        grossAmount,
        discount,
        insuranceDiscount,
        totalDiscount,
        netAmount,
        paidAmount,
        remainingAmount,
      ];
}
