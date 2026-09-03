import 'package:equatable/equatable.dart';

// ============================================================
// PATIENTS LIST QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/patients
//   search, clinic, receptionist, date_from, date_to, per_page, page
// ============================================================

/// Per-page dropdown options (matches web admin).
class PatientsListPerPage {
  PatientsListPerPage._();

  static const int defaultSize = 50;

  /// Large page size when user picks "All".
  static const int all = 10000;

  static const List<int> options = [50, 100, 200, 500, 1000];

  static const String allLabel = 'All';

  static List<String> get dropdownLabels => [
        '50',
        '100',
        '200',
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

class PatientsListQuery extends Equatable {
  const PatientsListQuery({
    this.search = '',
    this.clinic = '',
    this.receptionist = '',
    this.dateFrom,
    this.dateTo,
    this.perPage = PatientsListPerPage.defaultSize,
    this.page = 1,
  });

  final String search;
  final String clinic;
  final String receptionist;

  /// Display date (MM/dd/yyyy) from the filter panel.
  final String? dateFrom;
  final String? dateTo;
  final int perPage;
  final int page;

  PatientsListQuery copyWith({
    String? search,
    String? clinic,
    String? receptionist,
    String? dateFrom,
    String? dateTo,
    int? perPage,
    int? page,
    bool clearClinic = false,
    bool clearReceptionist = false,
    bool clearDateFrom = false,
    bool clearDateTo = false,
  }) {
    return PatientsListQuery(
      search: search ?? this.search,
      clinic: clearClinic ? '' : (clinic ?? this.clinic),
      receptionist: clearReceptionist ? '' : (receptionist ?? this.receptionist),
      dateFrom: clearDateFrom ? null : (dateFrom ?? this.dateFrom),
      dateTo: clearDateTo ? null : (dateTo ?? this.dateTo),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  PatientsListQuery resetFilters() {
    return PatientsListQuery(
      search: search,
      perPage: PatientsListPerPage.defaultSize,
      page: 1,
    );
  }

  bool get hasActiveFilters =>
      clinic.trim().isNotEmpty ||
      receptionist.trim().isNotEmpty ||
      dateFrom != null ||
      dateTo != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    params['per_page'] = perPage;

    final trimmedSearch = search.trim();
    if (trimmedSearch.isNotEmpty) params['search'] = trimmedSearch;

    final trimmedClinic = clinic.trim();
    if (trimmedClinic.isNotEmpty) params['clinic'] = trimmedClinic;

    final trimmedReceptionist = receptionist.trim();
    if (trimmedReceptionist.isNotEmpty) {
      params['receptionist'] = trimmedReceptionist;
    }

    final from = _toApiDate(dateFrom);
    if (from != null) params['date_from'] = from;
    final to = _toApiDate(dateTo);
    if (to != null) params['date_to'] = to;

    return params;
  }

  /// MM/dd/yyyy or ISO → yyyy-MM-dd
  static String? _toApiDate(String? raw) {
    final text = raw?.trim() ?? '';
    if (text.isEmpty) return null;
    final iso = DateTime.tryParse(text);
    if (iso != null) {
      final m = iso.month.toString().padLeft(2, '0');
      final d = iso.day.toString().padLeft(2, '0');
      return '${iso.year}-$m-$d';
    }
    final parts = text.split(RegExp(r'[/-]'));
    if (parts.length != 3) return text;
    final a = int.tryParse(parts[0]);
    final b = int.tryParse(parts[1]);
    final yRaw = int.tryParse(parts[2]);
    if (a == null || b == null || yRaw == null) return text;
    final year = yRaw < 100 ? 2000 + yRaw : yRaw;
    // Display filter uses MM/dd/yyyy.
    final month = a.toString().padLeft(2, '0');
    final day = b.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  @override
  List<Object?> get props => [
        search,
        clinic,
        receptionist,
        dateFrom,
        dateTo,
        perPage,
        page,
      ];
}
