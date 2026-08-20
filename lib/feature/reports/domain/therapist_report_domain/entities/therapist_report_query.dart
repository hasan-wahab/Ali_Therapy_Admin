import 'package:equatable/equatable.dart';

// ============================================================
// THERAPIST REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/therapist
// ============================================================

class TherapistReportQuery extends Equatable {
  const TherapistReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.therapistId,
    this.clinicId,
    this.perPage = 15,
    this.page = 1,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? therapistId;
  final int? clinicId;
  final int perPage;
  final int page;

  TherapistReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? therapistId,
    int? clinicId,
    int? perPage,
    int? page,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearTherapistId = false,
    bool clearClinicId = false,
  }) {
    return TherapistReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      therapistId:
          clearTherapistId ? null : (therapistId ?? this.therapistId),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  TherapistReportQuery resetFilters() => TherapistReportQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      therapistId != null ||
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
    if (therapistId != null) params['therapist_id'] = therapistId;
    if (clinicId != null) params['clinic_id'] = clinicId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        therapistId,
        clinicId,
        perPage,
        page,
      ];
}
