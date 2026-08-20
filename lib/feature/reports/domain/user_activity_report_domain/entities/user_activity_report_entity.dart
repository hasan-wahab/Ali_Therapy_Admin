import 'package:equatable/equatable.dart';

// ============================================================
// USER ACTIVITY REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/user-activity
// ============================================================

class UserActivityReportEntity extends Equatable {
  const UserActivityReportEntity({
    required this.id,
    required this.patientName,
    required this.patientCnic,
    required this.packageName,
    required this.sessionsUsed,
    required this.sessionsTotal,
    required this.remaining,
    required this.invoiceType,
    required this.paymentDate,
    required this.paymentMethod,
    required this.amount,
  });

  final String id;
  final String patientName;
  final String patientCnic;
  final String packageName;
  final int sessionsUsed;
  final int sessionsTotal;
  final int remaining;
  final String invoiceType;
  final String paymentDate;
  final String paymentMethod;
  final double amount;

  @override
  List<Object?> get props => [
        id,
        patientName,
        patientCnic,
        packageName,
        sessionsUsed,
        sessionsTotal,
        remaining,
        invoiceType,
        paymentDate,
        paymentMethod,
        amount,
      ];
}
