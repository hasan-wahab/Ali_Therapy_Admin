import 'package:equatable/equatable.dart';

// ============================================================
// ASSISTANT MANAGER REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/assistant-manager
// ============================================================

class AssistantManagerReportQuery extends Equatable {
  const AssistantManagerReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.assistantManagerId,
    this.clinicId,
    this.perPage = 15,
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
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
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
