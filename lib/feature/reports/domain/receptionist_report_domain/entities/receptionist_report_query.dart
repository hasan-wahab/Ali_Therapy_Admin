import 'package:equatable/equatable.dart';

// ============================================================
// RECEPTIONIST REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/receptionist
// ============================================================

class ReceptionistReportQuery extends Equatable {
  const ReceptionistReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.receptionistId,
    this.clinicId,
    this.perPage = 15,
    this.page = 1,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? receptionistId;
  final int? clinicId;
  final int perPage;
  final int page;

  ReceptionistReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? receptionistId,
    int? clinicId,
    int? perPage,
    int? page,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearReceptionistId = false,
    bool clearClinicId = false,
  }) {
    return ReceptionistReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      receptionistId:
          clearReceptionistId ? null : (receptionistId ?? this.receptionistId),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  ReceptionistReportQuery resetFilters() => ReceptionistReportQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      receptionistId != null ||
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
    if (receptionistId != null) params['receptionist_id'] = receptionistId;
    if (clinicId != null) params['clinic_id'] = clinicId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        receptionistId,
        clinicId,
        perPage,
        page,
      ];
}
