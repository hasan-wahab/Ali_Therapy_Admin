import 'package:equatable/equatable.dart';

// ============================================================
// USER ACTIVITY PAYMENT (Domain)
// ------------------------------------------------------------
// One item from record.payments_breakdown
// ============================================================

class UserActivityPaymentEntity extends Equatable {
  const UserActivityPaymentEntity({
    required this.date,
    required this.type,
    required this.amount,
    required this.method,
  });

  final String date;
  final String type;
  final double amount;
  final String method;

  @override
  List<Object?> get props => [date, type, amount, method];
}

// ============================================================
// USER ACTIVITY REPORT ENTITY (Domain)
// ------------------------------------------------------------
// One row from GET /api/admin/reports/user-activity
// ============================================================

class UserActivityReportEntity extends Equatable {
  const UserActivityReportEntity({
    required this.id,
    this.patientId = '',
    required this.patientName,
    required this.patientCnic,
    required this.packageName,
    required this.sessionsUsed,
    required this.sessionsTotal,
    required this.remaining,
    required this.invoiceType,
    required this.amount,
    this.paymentCount = 0,
    this.recordType = '',
    this.payments = const [],
  });

  final String id;
  final String patientId;
  final String patientName;
  final String patientCnic;
  final String packageName;
  final int sessionsUsed;
  final int sessionsTotal;
  final int remaining;
  final String invoiceType;

  /// Invoice total from payment_amount.
  final double amount;
  final int paymentCount;
  final String recordType;
  final List<UserActivityPaymentEntity> payments;

  String get paymentDate => payments.isEmpty ? '' : payments.first.date;

  String get paymentMethod {
    final methods = payments
        .map((p) => p.method.trim())
        .where((method) => method.isNotEmpty)
        .toList();
    return methods.join(', ');
  }

  List<String> get searchFields => [
        patientName,
        patientCnic,
        packageName,
        invoiceType,
        paymentMethod,
        ...payments.map((p) => p.date),
        ...payments.map((p) => p.method),
      ];

  @override
  List<Object?> get props => [
        id,
        patientId,
        patientName,
        patientCnic,
        packageName,
        sessionsUsed,
        sessionsTotal,
        remaining,
        invoiceType,
        amount,
        paymentCount,
        recordType,
        payments,
      ];
}
