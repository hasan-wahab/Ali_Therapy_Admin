import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/patient-report
// ============================================================

class PatientReportQuery extends Equatable {
  const PatientReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.consultantId,
    this.therapistId,
    this.assistantManagerId,
    this.receptionistId,
    this.perPage = 15,
    this.page = 1,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? clinicId;
  final int? consultantId;
  final int? therapistId;
  final int? assistantManagerId;
  final int? receptionistId;
  final int perPage;
  final int page;

  PatientReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? clinicId,
    int? consultantId,
    int? therapistId,
    int? assistantManagerId,
    int? receptionistId,
    int? perPage,
    int? page,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearClinicId = false,
    bool clearConsultantId = false,
    bool clearTherapistId = false,
    bool clearAssistantManagerId = false,
    bool clearReceptionistId = false,
  }) {
    return PatientReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      consultantId:
          clearConsultantId ? null : (consultantId ?? this.consultantId),
      therapistId: clearTherapistId ? null : (therapistId ?? this.therapistId),
      assistantManagerId: clearAssistantManagerId
          ? null
          : (assistantManagerId ?? this.assistantManagerId),
      receptionistId:
          clearReceptionistId ? null : (receptionistId ?? this.receptionistId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  PatientReportQuery resetFilters() => PatientReportQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  /// True when date / clinic / staff filters are applied.
  bool get hasActiveFilters =>
      fromDate != null ||
      toDate != null ||
      clinicId != null ||
      consultantId != null ||
      therapistId != null ||
      assistantManagerId != null ||
      receptionistId != null;

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    if (clinicId != null) params['clinic_id'] = clinicId;
    if (consultantId != null) params['consultant_id'] = consultantId;
    if (therapistId != null) params['therapist_id'] = therapistId;
    if (assistantManagerId != null) {
      params['assistant_manager_id'] = assistantManagerId;
    }
    if (receptionistId != null) params['receptionist_id'] = receptionistId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        clinicId,
        consultantId,
        therapistId,
        assistantManagerId,
        receptionistId,
        perPage,
        page,
      ];
}
