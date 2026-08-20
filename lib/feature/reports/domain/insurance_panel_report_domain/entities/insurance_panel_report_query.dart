import 'package:equatable/equatable.dart';

// ============================================================
// INSURANCE PANEL REPORT QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/reports/insurance-panel
// ============================================================

class InsurancePanelReportQuery extends Equatable {
  const InsurancePanelReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;

  InsurancePanelReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? clinicId,
    int? receptionistId,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearClinicId = false,
    bool clearReceptionistId = false,
  }) {
    return InsurancePanelReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      receptionistId:
          clearReceptionistId ? null : (receptionistId ?? this.receptionistId),
    );
  }

  InsurancePanelReportQuery resetFilters() =>
      InsurancePanelReportQuery(search: search);

  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      clinicId != null ||
      receptionistId != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    if (clinicId != null) params['clinic_id'] = clinicId;
    if (receptionistId != null) params['receptionist_id'] = receptionistId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        clinicId,
        receptionistId,
      ];
}
