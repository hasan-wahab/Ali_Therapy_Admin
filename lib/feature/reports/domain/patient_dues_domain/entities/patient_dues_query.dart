import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DUES QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/patient-dues
// ============================================================

/// Per-page dropdown (matches the web patient dues report).
class PatientDuesPerPage {
  PatientDuesPerPage._();

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

class PatientDuesQuery extends Equatable {
  const PatientDuesQuery({
    this.search = '',
    this.dateFrom,
    this.dateTo,
    this.clinicId,
    this.receptionistId,
    this.perPage = PatientDuesPerPage.defaultSize,
    this.page = 1,
  });

  final String search;
  final String? dateFrom; // yyyy-MM-dd
  final String? dateTo;
  final int? clinicId;
  final int? receptionistId;
  final int perPage;
  final int page;

  PatientDuesQuery copyWith({
    String? search,
    String? dateFrom,
    String? dateTo,
    int? clinicId,
    int? receptionistId,
    int? perPage,
    int? page,
    bool clearDateFrom = false,
    bool clearDateTo = false,
    bool clearClinicId = false,
    bool clearReceptionistId = false,
  }) {
    return PatientDuesQuery(
      search: search ?? this.search,
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      receptionistId: clearReceptionistId
          ? null
          : (receptionistId ?? this.receptionistId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  PatientDuesQuery resetFilters() => PatientDuesQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  bool get hasActiveFilters =>
      dateFrom != null ||
      dateTo != null ||
      clinicId != null ||
      receptionistId != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    if (perPage != PatientDuesPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (dateFrom != null) params['date_from'] = dateFrom;
    if (dateTo != null) params['date_to'] = dateTo;
    if (clinicId != null) params['clinic_id'] = clinicId;
    if (receptionistId != null) params['receptionist_id'] = receptionistId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        dateFrom,
        dateTo,
        clinicId,
        receptionistId,
        perPage,
        page,
      ];
}
