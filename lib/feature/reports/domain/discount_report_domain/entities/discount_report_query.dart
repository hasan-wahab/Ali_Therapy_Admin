import 'package:equatable/equatable.dart';

// ============================================================
// DISCOUNT REPORT QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/reports/discount
// clinic_id, consultant_id, receptionist_id, from_date, to_date,
// search, per_page
// discountPercent is UI-only (not sent to the API).
// ============================================================

/// Per-page dropdown (matches the web discount report).
class DiscountReportPerPage {
  DiscountReportPerPage._();

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

class DiscountReportQuery extends Equatable {
  const DiscountReportQuery({
    this.search = '',
    this.clinicId,
    this.consultantId,
    this.receptionistId,
    this.fromDate,
    this.toDate,
    this.discountPercent,
    this.perPage = DiscountReportPerPage.defaultSize,
    this.page = 1,
  });

  final String search;
  final int? clinicId;
  final int? consultantId;
  final int? receptionistId;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? discountPercent;
  final int perPage;
  final int page;

  DiscountReportQuery copyWith({
    String? search,
    int? clinicId,
    int? consultantId,
    int? receptionistId,
    String? fromDate,
    String? toDate,
    int? discountPercent,
    int? perPage,
    int? page,
    bool clearClinicId = false,
    bool clearConsultantId = false,
    bool clearReceptionistId = false,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearDiscountPercent = false,
  }) {
    return DiscountReportQuery(
      search: search ?? this.search,
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      consultantId:
          clearConsultantId ? null : (consultantId ?? this.consultantId),
      receptionistId:
          clearReceptionistId ? null : (receptionistId ?? this.receptionistId),
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      discountPercent: clearDiscountPercent
          ? null
          : (discountPercent ?? this.discountPercent),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  DiscountReportQuery resetFilters() => DiscountReportQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  bool get hasActiveFilters =>
      clinicId != null ||
      consultantId != null ||
      receptionistId != null ||
      fromDate != null ||
      toDate != null ||
      discountPercent != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    if (perPage != DiscountReportPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (clinicId != null) params['clinic_id'] = clinicId;
    if (consultantId != null) params['consultant_id'] = consultantId;
    if (receptionistId != null) params['receptionist_id'] = receptionistId;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        clinicId,
        consultantId,
        receptionistId,
        fromDate,
        toDate,
        discountPercent,
        perPage,
        page,
      ];
}
