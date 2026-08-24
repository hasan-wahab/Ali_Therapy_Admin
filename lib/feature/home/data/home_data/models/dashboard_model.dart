import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';

// ============================================================
// DASHBOARD MODEL (Data)
// ------------------------------------------------------------
// Parses GET /api/admin/dashboard/overview
// Prefer summary_cards, then cards_list, then root fields.
// ============================================================

class DashboardOverviewStatModel extends DashboardOverviewStatEntity {
  const DashboardOverviewStatModel({
    required super.key,
    required super.title,
    required super.formattedValue,
    super.subtitle,
  });

  factory DashboardOverviewStatModel.fromJson(
    Map<String, dynamic> json, {
    required String fallbackKey,
    required String fallbackTitle,
  }) {
    final formatted = json['formatted_value']?.toString().trim();
    final rawValue = json['value'];
    return DashboardOverviewStatModel(
      key: json['key']?.toString().trim().isNotEmpty == true
          ? json['key'].toString().trim()
          : fallbackKey,
      title: json['title']?.toString().trim().isNotEmpty == true
          ? json['title'].toString().trim()
          : fallbackTitle,
      formattedValue: (formatted != null && formatted.isNotEmpty)
          ? formatted
          : (rawValue?.toString() ?? '0'),
      subtitle: _subtitleOf(json),
    );
  }

  DashboardOverviewStatEntity toEntity() {
    return DashboardOverviewStatEntity(
      key: key,
      title: title,
      formattedValue: formattedValue,
      subtitle: subtitle,
    );
  }

  static String? _subtitleOf(Map<String, dynamic> json) {
    final subtitle = json['subtitle']?.toString().trim();
    if (subtitle != null && subtitle.isNotEmpty) return subtitle;
    final badge = json['badge']?.toString().trim();
    if (badge != null && badge.isNotEmpty) return badge;
    return null;
  }
}

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.totalEmployees,
    required super.totalPatients,
    required super.monthlyIncome,
    required super.monthlyExpenses,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final summaryCards = _asMap(json['summary_cards']);
    final cardsByKey = _cardsByKey(json['cards_list']);

    return DashboardModel(
      totalEmployees: _statOf(
        json: json,
        summaryCards: summaryCards,
        cardsByKey: cardsByKey,
        key: 'total_employees',
        fallbackTitle: 'Total Employees',
        rootValueKey: 'total_employees',
      ),
      totalPatients: _statOf(
        json: json,
        summaryCards: summaryCards,
        cardsByKey: cardsByKey,
        key: 'total_patients',
        fallbackTitle: 'Total Patients',
        rootValueKey: 'total_patients',
        rootSubtitleKey: 'patients_this_week',
        rootSubtitlePrefix: '+',
        rootSubtitleSuffix: ' this week',
      ),
      monthlyIncome: _statOf(
        json: json,
        summaryCards: summaryCards,
        cardsByKey: cardsByKey,
        key: 'monthly_income',
        fallbackTitle: 'Monthly Income',
        rootValueKey: 'monthly_income',
        rootFormattedKey: 'monthly_income_formatted',
        fallbackSubtitle: 'this month',
      ),
      monthlyExpenses: _statOf(
        json: json,
        summaryCards: summaryCards,
        cardsByKey: cardsByKey,
        key: 'monthly_expenses',
        fallbackTitle: 'Monthly Expenses',
        rootValueKey: 'monthly_expenses',
        rootFormattedKey: 'monthly_expenses_formatted',
        fallbackSubtitle: 'this month',
      ),
    );
  }

  DashboardEntity toEntity() {
    return DashboardEntity(
      totalEmployees: totalEmployees,
      totalPatients: totalPatients,
      monthlyIncome: monthlyIncome,
      monthlyExpenses: monthlyExpenses,
    );
  }

  static DashboardOverviewStatModel _statOf({
    required Map<String, dynamic> json,
    required Map<String, dynamic>? summaryCards,
    required Map<String, Map<String, dynamic>> cardsByKey,
    required String key,
    required String fallbackTitle,
    required String rootValueKey,
    String? rootFormattedKey,
    String? rootSubtitleKey,
    String rootSubtitlePrefix = '',
    String rootSubtitleSuffix = '',
    String? fallbackSubtitle,
  }) {
    final fromSummary = _asMap(summaryCards?[key]);
    if (fromSummary != null) {
      return DashboardOverviewStatModel.fromJson(
        fromSummary,
        fallbackKey: key,
        fallbackTitle: fallbackTitle,
      );
    }

    final fromList = cardsByKey[key];
    if (fromList != null) {
      return DashboardOverviewStatModel.fromJson(
        fromList,
        fallbackKey: key,
        fallbackTitle: fallbackTitle,
      );
    }

    final formatted = json[rootFormattedKey]?.toString().trim();
    final value = json[rootValueKey];
    String? subtitle = fallbackSubtitle;
    if (rootSubtitleKey != null) {
      final weekCount = json[rootSubtitleKey];
      if (weekCount != null) {
        subtitle = '$rootSubtitlePrefix$weekCount$rootSubtitleSuffix';
      }
    }

    return DashboardOverviewStatModel(
      key: key,
      title: fallbackTitle,
      formattedValue: (formatted != null && formatted.isNotEmpty)
          ? formatted
          : (value?.toString() ?? '0'),
      subtitle: subtitle,
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

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }
}
