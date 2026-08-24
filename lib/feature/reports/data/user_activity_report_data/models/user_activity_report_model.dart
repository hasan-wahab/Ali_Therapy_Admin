import '../../../domain/user_activity_report_domain/entities/user_activity_report_entity.dart';
import '../../../domain/user_activity_report_domain/entities/user_activity_report_page_entity.dart';
import '../../../domain/user_activity_report_domain/entities/user_activity_report_summary_entity.dart';

// ============================================================
// USER ACTIVITY PAYMENT MODEL
// ------------------------------------------------------------
// Parses one item from payments_breakdown
// ============================================================

class UserActivityPaymentModel extends UserActivityPaymentEntity {
  const UserActivityPaymentModel({
    required super.date,
    required super.type,
    required super.amount,
    required super.method,
  });

  factory UserActivityPaymentModel.fromJson(Map<String, dynamic> json) {
    return UserActivityPaymentModel(
      date: _text(json['payment_date'] ?? json['date']),
      type: _text(json['payment_type'] ?? json['type']),
      amount: _toDouble(json['payment_amount'] ?? json['amount']),
      method: _text(json['payment_method'] ?? json['method']),
    );
  }

  UserActivityPaymentEntity toEntity() => UserActivityPaymentEntity(
        date: date,
        type: type,
        amount: amount,
        method: method,
      );

  static String _text(dynamic value) => value?.toString().trim() ?? '';

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}

// ============================================================
// USER ACTIVITY REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/user-activity
// ============================================================

class UserActivityReportModel extends UserActivityReportEntity {
  const UserActivityReportModel({
    required super.id,
    super.patientId,
    required super.patientName,
    required super.patientCnic,
    required super.packageName,
    required super.sessionsUsed,
    required super.sessionsTotal,
    required super.remaining,
    required super.invoiceType,
    required super.amount,
    super.paymentCount,
    super.recordType,
    super.payments,
  });

  factory UserActivityReportModel.fromJson(Map<String, dynamic> json) {
    final payments = _paymentsOf(json);
    final amount = _toDouble(json['payment_amount'] ?? json['amount']);

    return UserActivityReportModel(
      id: (json['invoice_id'] ?? json['id'])?.toString() ?? '',
      patientId: json['patient_id']?.toString() ?? '',
      patientName: _text(json['patient_name']),
      patientCnic: _text(json['patient_cnic']),
      packageName: _text(json['package_name']),
      sessionsUsed: _toInt(json['sessions_used']),
      sessionsTotal: _toInt(json['sessions_total']),
      remaining: _toInt(
        json['sessions_remaining'] ?? json['remaining'],
      ),
      invoiceType: _text(json['invoice_type']),
      amount: amount,
      paymentCount: _toInt(json['payment_count'], fallback: payments.length),
      recordType: _text(json['record_type']),
      payments: payments.isNotEmpty
          ? payments
          : (amount == 0
              ? const []
              : [
                  UserActivityPaymentModel(
                    date: _text(json['payment_date']),
                    type: _text(json['payment_type']),
                    amount: amount,
                    method: _text(json['payment_method']),
                  ),
                ]),
    );
  }

  static List<UserActivityPaymentEntity> _paymentsOf(
    Map<String, dynamic> json,
  ) {
    final raw = json['payments_breakdown'] ?? json['payments'];
    if (raw is! List) return const [];
    return raw
        .whereType<Map>()
        .map(
          (e) => UserActivityPaymentModel.fromJson(
            Map<String, dynamic>.from(e),
          ),
        )
        .toList();
  }

  static String _text(dynamic value) => value?.toString().trim() ?? '';

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value == null) return fallback;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? fallback;
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static List<UserActivityReportModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map(
        (e) => UserActivityReportModel.fromJson(Map<String, dynamic>.from(e)),
      )
      .toList();

  UserActivityReportEntity toEntity() => UserActivityReportEntity(
        id: id,
        patientId: patientId,
        patientName: patientName,
        patientCnic: patientCnic,
        packageName: packageName,
        sessionsUsed: sessionsUsed,
        sessionsTotal: sessionsTotal,
        remaining: remaining,
        invoiceType: invoiceType,
        amount: amount,
        paymentCount: paymentCount,
        recordType: recordType,
        payments: payments,
      );
}

// ============================================================
// USER ACTIVITY REPORT PAGE MODEL
// ------------------------------------------------------------
// data.records + data.pagination + data.summary_cards
// ============================================================

class UserActivityReportPageModel extends UserActivityReportPageEntity {
  const UserActivityReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory UserActivityReportPageModel.fromJson(Map<String, dynamic> json) {
    final nested = _asMap(json['data']);
    if (nested != null &&
        (nested['records'] != null || nested['summary_cards'] != null)) {
      json = nested;
    }

    final list = json['records'] ?? json['data'];
    final rows = list is List
        ? UserActivityReportModel.listFromJson(list)
        : <UserActivityReportModel>[];

    final pagination = _asMap(json['pagination']) ?? json;

    return UserActivityReportPageModel(
      rows: rows,
      currentPage: _toInt(pagination['current_page'], fallback: 1),
      lastPage: _toInt(pagination['last_page'], fallback: 1),
      total: _toInt(pagination['total'], fallback: rows.length),
      summary: UserActivityReportSummaryModel.fromJson(json),
    );
  }

  UserActivityReportPageEntity toEntity() => UserActivityReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value == null) return fallback;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? fallback;
  }
}

// ============================================================
// USER ACTIVITY REPORT SUMMARY MODEL
// ------------------------------------------------------------
// Prefer summary_cards, then cards_list, then summary.
// ============================================================

class UserActivityReportSummaryModel extends UserActivityReportSummaryEntity {
  const UserActivityReportSummaryModel({
    required super.packages,
    required super.consultations,
    required super.walletTopups,
    required super.grandTotal,
  });

  factory UserActivityReportSummaryModel.fromRows(
    List<UserActivityReportEntity> rows,
  ) {
    final entity = UserActivityReportSummaryEntity.fromRows(rows);
    return UserActivityReportSummaryModel(
      packages: entity.packages,
      consultations: entity.consultations,
      walletTopups: entity.walletTopups,
      grandTotal: entity.grandTotal,
    );
  }

  factory UserActivityReportSummaryModel.fromJson(Map<String, dynamic> json) {
    final summaryCards = _asMap(json['summary_cards']);
    final cardsByKey = _cardsByKey(json['cards_list']);
    final summary = _asMap(json['summary']) ??
        _asMap(json['totals']) ??
        _asMap(json['stats']);

    final packages = _cardBreakdown(
      summaryCards: summaryCards,
      cardsByKey: cardsByKey,
      key: 'packages',
      fallback: _legacyBreakdown(
        summary,
        totalKeys: const [
          'total_packages_amount',
          'packages_total',
          'packages',
        ],
        mapKeys: const ['package_breakdown', 'packages'],
      ),
    );
    final consultations = _cardBreakdown(
      summaryCards: summaryCards,
      cardsByKey: cardsByKey,
      key: 'consultations',
      fallback: _legacyBreakdown(
        summary,
        totalKeys: const [
          'total_consultations_amount',
          'consultations_total',
          'consultations',
        ],
        mapKeys: const ['consultation_breakdown', 'consultations'],
      ),
    );
    final walletTopups = _cardBreakdown(
      summaryCards: summaryCards,
      cardsByKey: cardsByKey,
      key: 'wallet_topups',
      fallback: _legacyBreakdown(
        summary,
        totalKeys: const [
          'total_wallet_topups_amount',
          'wallet_topups_total',
          'wallet_topups',
        ],
        mapKeys: const ['wallet_breakdown', 'wallet_topups'],
      ),
    );

    final grandCard = _asMap(summaryCards?['grand_total']) ??
        cardsByKey['grand_total'] ??
        _asMap(summary?['grand_total']);
    final grandTotal = _toDouble(
      grandCard?['total'] ??
          summary?['grand_total'] ??
          summary?['grandTotal'] ??
          summary?['total_amount'],
    );

    return UserActivityReportSummaryModel(
      packages: packages,
      consultations: consultations,
      walletTopups: walletTopups,
      grandTotal: grandTotal == 0
          ? packages.total + consultations.total + walletTopups.total
          : grandTotal,
    );
  }

  static UserActivityPaymentBreakdownEntity _cardBreakdown({
    required Map<String, dynamic>? summaryCards,
    required Map<String, Map<String, dynamic>> cardsByKey,
    required String key,
    required UserActivityPaymentBreakdownEntity fallback,
  }) {
    final fromCards = _asMap(summaryCards?[key]) ?? cardsByKey[key];
    if (fromCards != null) {
      final parsed = _breakdownFromJson(fromCards);
      if (!parsed.isEmpty) return parsed;
    }
    return fallback;
  }

  static UserActivityPaymentBreakdownEntity _legacyBreakdown(
    Map<String, dynamic>? summary, {
    required List<String> totalKeys,
    required List<String> mapKeys,
  }) {
    if (summary == null) {
      return const UserActivityPaymentBreakdownEntity.empty();
    }

    for (final key in mapKeys) {
      final map = _asMap(summary[key]);
      if (map != null) {
        final parsed = _breakdownFromJson(map);
        if (!parsed.isEmpty) {
          final total = _firstDouble(summary, totalKeys);
          if (total == 0 || parsed.total > 0) return parsed;
          return UserActivityPaymentBreakdownEntity(
            total: total,
            cash: parsed.cash,
            wallet: parsed.wallet,
            card: parsed.card,
            qr: parsed.qr,
            accountTransfer: parsed.accountTransfer,
          );
        }
      }
    }

    return const UserActivityPaymentBreakdownEntity.empty();
  }

  static UserActivityPaymentBreakdownEntity _breakdownFromJson(
    Map<String, dynamic> json,
  ) {
    final methods = _asMap(json['breakdown']) ?? json;
    return UserActivityPaymentBreakdownEntity(
      total: _toDouble(json['total'] ?? json['amount'] ?? methods['total']),
      cash: _toDouble(methods['cash']),
      wallet: _toDouble(methods['wallet']),
      card: _toDouble(methods['card']),
      qr: _toDouble(methods['qr'] ?? methods['qr_payment']),
      accountTransfer: _toDouble(
        methods['account_transfer'] ??
            methods['accountTransfer'] ??
            methods['bank_transfer'],
      ),
    );
  }

  static Map<String, Map<String, dynamic>> _cardsByKey(dynamic rawList) {
    final result = <String, Map<String, dynamic>>{};
    if (rawList is! List) return result;
    for (final item in rawList) {
      final map = _asMap(item);
      if (map == null) continue;
      final key = map['key']?.toString().trim();
      if (key == null || key.isEmpty) continue;
      result[key] = map;
    }
    return result;
  }

  static double _firstDouble(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      final value = _toDouble(json[key]);
      if (value != 0) return value;
    }
    return 0;
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  UserActivityReportSummaryEntity toEntity() => UserActivityReportSummaryEntity(
        packages: packages,
        consultations: consultations,
        walletTopups: walletTopups,
        grandTotal: grandTotal,
      );
}
