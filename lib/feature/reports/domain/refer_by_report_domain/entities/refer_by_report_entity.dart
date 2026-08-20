import 'package:equatable/equatable.dart';

// ============================================================
// REFER BY REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One referral-source row from GET /api/admin/reports/refer-by
// ============================================================

class ReferByReportEntity extends Equatable {
  const ReferByReportEntity({
    required this.id,
    required this.referralSource,
    required this.referralType,
    required this.patientCount,
    required this.grossBilled,
    required this.consultation,
    required this.packageBilled,
    required this.directDiscount,
    required this.insuranceDiscount,
    required this.packagePaid,
    required this.totalReceived,
    required this.dues,
  });

  final String id;
  final String referralSource;
  final String referralType;
  final int patientCount;
  final double grossBilled;
  final double consultation;
  final double packageBilled;
  final double directDiscount;
  final double insuranceDiscount;
  final double packagePaid;
  final double totalReceived;
  final double dues;

  @override
  List<Object?> get props => [
        id,
        referralSource,
        referralType,
        patientCount,
        grossBilled,
        consultation,
        packageBilled,
        directDiscount,
        insuranceDiscount,
        packagePaid,
        totalReceived,
        dues,
      ];
}
