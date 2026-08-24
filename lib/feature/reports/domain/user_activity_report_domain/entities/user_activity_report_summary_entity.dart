import 'package:equatable/equatable.dart';

import 'user_activity_report_entity.dart';

// ============================================================
// USER ACTIVITY PAYMENT BREAKDOWN (Domain)
// ------------------------------------------------------------
// One bucket (packages / consultations / wallet top-ups)
// split by payment method.
// ============================================================

class UserActivityPaymentBreakdownEntity extends Equatable {
  const UserActivityPaymentBreakdownEntity({
    required this.total,
    required this.cash,
    required this.wallet,
    required this.card,
    required this.qr,
    required this.accountTransfer,
  });

  const UserActivityPaymentBreakdownEntity.empty()
      : total = 0,
        cash = 0,
        wallet = 0,
        card = 0,
        qr = 0,
        accountTransfer = 0;

  final double total;
  final double cash;
  final double wallet;
  final double card;
  final double qr;
  final double accountTransfer;

  bool get isEmpty =>
      total == 0 &&
      cash == 0 &&
      wallet == 0 &&
      card == 0 &&
      qr == 0 &&
      accountTransfer == 0;

  UserActivityPaymentBreakdownEntity add(String paymentMethod, double amount) {
    var nextCash = cash;
    var nextWallet = wallet;
    var nextCard = card;
    var nextQr = qr;
    var nextTransfer = accountTransfer;
    final method = paymentMethod.toLowerCase().trim();

    if (method.contains('cash')) {
      nextCash += amount;
    } else if (method.contains('wallet')) {
      nextWallet += amount;
    } else if (method.contains('qr')) {
      nextQr += amount;
    } else if (method.contains('card') ||
        method.contains('credit') ||
        method.contains('debit')) {
      nextCard += amount;
    } else if (method.contains('transfer') ||
        method.contains('bank') ||
        method.contains('account')) {
      nextTransfer += amount;
    }

    return UserActivityPaymentBreakdownEntity(
      total: total + amount,
      cash: nextCash,
      wallet: nextWallet,
      card: nextCard,
      qr: nextQr,
      accountTransfer: nextTransfer,
    );
  }

  @override
  List<Object?> get props => [total, cash, wallet, card, qr, accountTransfer];
}

// ============================================================
// USER ACTIVITY REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the user activity screen.
// ============================================================

class UserActivityReportSummaryEntity extends Equatable {
  const UserActivityReportSummaryEntity({
    required this.packages,
    required this.consultations,
    required this.walletTopups,
    required this.grandTotal,
  });

  const UserActivityReportSummaryEntity.empty()
      : packages = const UserActivityPaymentBreakdownEntity.empty(),
        consultations = const UserActivityPaymentBreakdownEntity.empty(),
        walletTopups = const UserActivityPaymentBreakdownEntity.empty(),
        grandTotal = 0;

  final UserActivityPaymentBreakdownEntity packages;
  final UserActivityPaymentBreakdownEntity consultations;
  final UserActivityPaymentBreakdownEntity walletTopups;
  final double grandTotal;

  bool get isEmpty =>
      packages.isEmpty &&
      consultations.isEmpty &&
      walletTopups.isEmpty &&
      grandTotal == 0;

  /// Fallback when the API does not send a totals object.
  factory UserActivityReportSummaryEntity.fromRows(
    List<UserActivityReportEntity> rows,
  ) {
    var packages = const UserActivityPaymentBreakdownEntity.empty();
    var consultations = const UserActivityPaymentBreakdownEntity.empty();
    var walletTopups = const UserActivityPaymentBreakdownEntity.empty();

    for (final row in rows) {
      final type = row.invoiceType.toLowerCase();
      final items = row.payments.isNotEmpty
          ? row.payments
          : [
              UserActivityPaymentEntity(
                date: row.paymentDate,
                type: '',
                amount: row.amount,
                method: row.paymentMethod,
              ),
            ];

      for (final payment in items) {
        if (_isWalletTopup(type)) {
          walletTopups = walletTopups.add(payment.method, payment.amount);
        } else if (_isConsultation(type)) {
          consultations = consultations.add(payment.method, payment.amount);
        } else if (_isPackage(type)) {
          packages = packages.add(payment.method, payment.amount);
        }
      }
    }

    return UserActivityReportSummaryEntity(
      packages: packages,
      consultations: consultations,
      walletTopups: walletTopups,
      grandTotal: packages.total + consultations.total + walletTopups.total,
    );
  }

  static bool _isWalletTopup(String type) {
    return type.contains('topup') ||
        type.contains('top-up') ||
        type.contains('top up') ||
        (type.contains('wallet') && type.contains('top'));
  }

  static bool _isConsultation(String type) => type.contains('consult');

  static bool _isPackage(String type) => type.contains('package');

  @override
  List<Object?> get props => [packages, consultations, walletTopups, grandTotal];
}
