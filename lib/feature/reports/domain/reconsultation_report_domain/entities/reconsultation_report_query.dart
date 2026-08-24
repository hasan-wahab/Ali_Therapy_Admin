import 'package:equatable/equatable.dart';

// ============================================================
// RECONSULTATION REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/reconsultation
// ============================================================

/// Per-page dropdown (matches the web reconsultation report).
class ReconsultationReportPerPage {
  ReconsultationReportPerPage._();

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

class ReconsultationReportQuery extends Equatable {
  const ReconsultationReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.consultantId,
    this.clinicId,
    this.perPage = ReconsultationReportPerPage.defaultSize,
    this.page = 1,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? consultantId;
  final int? clinicId;
  final int perPage;
  final int page;

  ReconsultationReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? consultantId,
    int? clinicId,
    int? perPage,
    int? page,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearConsultantId = false,
    bool clearClinicId = false,
  }) {
    return ReconsultationReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      consultantId:
          clearConsultantId ? null : (consultantId ?? this.consultantId),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  ReconsultationReportQuery resetFilters() => ReconsultationReportQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      consultantId != null ||
      clinicId != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    if (perPage != ReconsultationReportPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    if (consultantId != null) params['consultant_id'] = consultantId;
    if (clinicId != null) params['clinic_id'] = clinicId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        consultantId,
        clinicId,
        perPage,
        page,
      ];
}
