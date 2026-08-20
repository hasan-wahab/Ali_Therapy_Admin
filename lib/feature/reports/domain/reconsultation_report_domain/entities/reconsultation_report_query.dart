import 'package:equatable/equatable.dart';

// ============================================================
// RECONSULTATION REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/reconsultation
// ============================================================

class ReconsultationReportQuery extends Equatable {
  const ReconsultationReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.consultantId,
    this.clinicId,
    this.perPage = 15,
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
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
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
