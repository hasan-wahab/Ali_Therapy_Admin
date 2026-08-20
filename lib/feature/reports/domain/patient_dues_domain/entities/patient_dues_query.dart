import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DUES QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/patient-dues
// ============================================================

class PatientDuesQuery extends Equatable {
  const PatientDuesQuery({
    this.search = '',
    this.dateFrom,
    this.dateTo,
    this.clinicId,
    this.receptionistId,
    this.perPage = 15,
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
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
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
