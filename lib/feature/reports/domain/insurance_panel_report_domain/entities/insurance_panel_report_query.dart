import 'package:equatable/equatable.dart';

// ============================================================
// INSURANCE PANEL REPORT QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/reports/insurance-panel
// ============================================================

/// Per-page dropdown (matches the web insurance panel report).
class InsurancePanelReportPerPage {
  InsurancePanelReportPerPage._();

  static const int defaultSize = 15;

  /// Large page size when user picks "All".
  static const int all = 10000;

  static const String allLabel = 'All';

  static List<String> get dropdownLabels => [
        '15',
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

class InsurancePanelReportQuery extends Equatable {
  const InsurancePanelReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
    this.perPage = InsurancePanelReportPerPage.defaultSize,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;
  final int perPage;

  InsurancePanelReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? clinicId,
    int? receptionistId,
    int? perPage,
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
      perPage: perPage ?? this.perPage,
    );
  }

  InsurancePanelReportQuery resetFilters() => InsurancePanelReportQuery(
        search: search,
        perPage: perPage,
      );

  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      clinicId != null ||
      receptionistId != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (perPage != InsurancePanelReportPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
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
        perPage,
      ];
}
