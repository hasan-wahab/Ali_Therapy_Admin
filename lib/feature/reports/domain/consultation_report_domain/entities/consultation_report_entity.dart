import 'package:equatable/equatable.dart';

// ============================================================
// CONSULTATION REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/consultant
// ============================================================

class ConsultationReportEntity extends Equatable {
  const ConsultationReportEntity({
    required this.id,
    required this.visitDate,
    required this.consultantName,
    required this.receptionistName,
    required this.assistantManagerName,
    required this.therapistName,
    required this.reviewStatus,
    required this.reviewRating,
    required this.patientName,
    required this.patientPhone,
    required this.patientCnic,
    required this.clinicName,
    required this.referBy,
    required this.totalBilled,
    required this.paidAmount,
    required this.discountAmount,
    required this.insuranceDiscount,
    required this.remainingBalance,
    required this.sessionsTotal,
    required this.sessionsUsed,
    required this.sessionsRemaining,
    required this.packageStatus,
  });

  final String id;
  final String visitDate;
  final String consultantName;
  final String receptionistName;
  final String assistantManagerName;
  final String therapistName;
  final String reviewStatus;
  final String reviewRating;
  final String patientName;
  final String patientPhone;
  final String patientCnic;
  final String clinicName;
  final String referBy;
  final double totalBilled;
  final double paidAmount;
  final double discountAmount;
  final double insuranceDiscount;
  final double remainingBalance;
  final int sessionsTotal;
  final int sessionsUsed;
  final int sessionsRemaining;
  final String packageStatus;

  bool get isReviewDone => reviewStatus.toLowerCase() == 'yes';

  bool get isPackageSuggested =>
      packageStatus.toLowerCase() == 'suggested';

  @override
  List<Object?> get props => [
        id,
        visitDate,
        consultantName,
        receptionistName,
        assistantManagerName,
        therapistName,
        reviewStatus,
        reviewRating,
        patientName,
        patientPhone,
        patientCnic,
        clinicName,
        referBy,
        totalBilled,
        paidAmount,
        discountAmount,
        insuranceDiscount,
        remainingBalance,
        sessionsTotal,
        sessionsUsed,
        sessionsRemaining,
        packageStatus,
      ];
}
