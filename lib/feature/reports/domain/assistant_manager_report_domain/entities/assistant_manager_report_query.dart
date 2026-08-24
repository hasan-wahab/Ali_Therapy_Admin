import 'package:equatable/equatable.dart';

// ============================================================
// ASSISTANT MANAGER REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/assistant-manager
// ============================================================

/// Per-page dropdown (matches the web assistant manager report).
class AssistantManagerReportPerPage {
  AssistantManagerReportPerPage._();

  static const int defaultSize = 10;

  /// Large page size when user picks "All".
  static const int all = 10000;

  static const String allLabel = 'All';

  static List<String> get dropdownLabels => [
        '10',
        '25',
        '50',
        '100',
        '250',
        '500',
        '1,000',
        allLabel,
      ];

  static String labelFor(int perPage) {
    if (perPage >= all) return allLabel;
    if (perPage == 1000) return '1,000';
    return perPage.toString();
  }

  static int valueForLabel(String label) {
    if (label == allLabel) return all;
    final normalized = label.replaceAll(',', '');
    return int.tryParse(normalized) ?? defaultSize;
  }
}

class AssistantManagerReportQuery extends Equatable {
  const AssistantManagerReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.assistantManagerId,
    this.clinicId,
    this.perPage = AssistantManagerReportPerPage.defaultSize,
    this.page = 1,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? assistantManagerId;
  final int? clinicId;
  final int perPage;
  final int page;

  AssistantManagerReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? assistantManagerId,
    int? clinicId,
    int? perPage,
    int? page,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearAssistantManagerId = false,
    bool clearClinicId = false,
  }) {
    return AssistantManagerReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      assistantManagerId: clearAssistantManagerId
          ? null
          : (assistantManagerId ?? this.assistantManagerId),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  AssistantManagerReportQuery resetFilters() => AssistantManagerReportQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      assistantManagerId != null ||
      clinicId != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    if (perPage != AssistantManagerReportPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    if (assistantManagerId != null) {
      params['assistant_manager_id'] = assistantManagerId;
    }
    if (clinicId != null) params['clinic_id'] = clinicId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        assistantManagerId,
        clinicId,
        perPage,
        page,
      ];
}
