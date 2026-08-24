import 'package:equatable/equatable.dart';

// ============================================================
// USER ACTIVITY REPORT QUERY (Domain)
// ------------------------------------------------------------
// GET /api/admin/reports/user-activity
// First load → no query params (API applies its own defaults).
// After Apply → only the filters the user selected.
//
// Optional params:
//   from_date        YYYY-MM-DD  (API default: 30 days ago)
//   to_date          YYYY-MM-DD  (API default: today)
//   clinic_id        int
//   receptionist_id  int
//   per_page         int         (API default: 15)
// ============================================================

/// Per-page dropdown (API default is 15).
class UserActivityReportPerPage {
  UserActivityReportPerPage._();

  static const int defaultSize = 15;

  /// Large page size when user picks "All".
  static const int all = 10000;

  static const String allLabel = 'All';

  static List<String> get dropdownLabels => [
        '10',
        '15',
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

class UserActivityReportQuery extends Equatable {
  const UserActivityReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
    this.perPage = UserActivityReportPerPage.defaultSize,
    this.page = 1,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;
  final int perPage;
  final int page;

  /// Shown in the filter panel when the user has not applied dates yet.
  static String get defaultFromDate =>
      _ymd(DateTime.now().subtract(const Duration(days: 30)));

  static String get defaultToDate => _ymd(DateTime.now());

  static String _ymd(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  /// True when both dates match the API defaults (omit from the URL).
  static bool areApiDefaultDates(String? fromDate, String? toDate) {
    return fromDate == defaultFromDate && toDate == defaultToDate;
  }

  UserActivityReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? clinicId,
    int? receptionistId,
    int? perPage,
    int? page,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearClinicId = false,
    bool clearReceptionistId = false,
  }) {
    return UserActivityReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      receptionistId:
          clearReceptionistId ? null : (receptionistId ?? this.receptionistId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  UserActivityReportQuery resetFilters() => UserActivityReportQuery(
        search: search,
      );

  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      clinicId != null ||
      receptionistId != null ||
      perPage != UserActivityReportPerPage.defaultSize;

  /// Empty map on first load → bare `/reports/user-activity`.
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    if (perPage != UserActivityReportPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (fromDate != null && fromDate!.isNotEmpty) {
      params['from_date'] = fromDate;
    }
    if (toDate != null && toDate!.isNotEmpty) {
      params['to_date'] = toDate;
    }
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
        page,
      ];
}
