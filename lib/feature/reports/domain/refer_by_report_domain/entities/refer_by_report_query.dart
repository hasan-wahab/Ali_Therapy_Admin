import 'package:equatable/equatable.dart';

// ============================================================
// REFER BY REPORT QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/reports/refer-by
// ============================================================

class ReferByReportQuery extends Equatable {
  const ReferByReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
    this.referralType,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;
  final String? referralType;

  ReferByReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? clinicId,
    int? receptionistId,
    String? referralType,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearClinicId = false,
    bool clearReceptionistId = false,
    bool clearReferralType = false,
  }) {
    return ReferByReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      receptionistId:
          clearReceptionistId ? null : (receptionistId ?? this.receptionistId),
      referralType:
          clearReferralType ? null : (referralType ?? this.referralType),
    );
  }

  ReferByReportQuery resetFilters() => ReferByReportQuery(search: search);

  bool get hasActiveFilters {
    final type = referralType?.trim() ?? '';
    return fromDate != null ||
        toDate != null ||
        clinicId != null ||
        receptionistId != null ||
        type.isNotEmpty;
  }

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    if (clinicId != null) params['clinic_id'] = clinicId;
    if (receptionistId != null) params['receptionist_id'] = receptionistId;
    final type = referralType?.trim();
    if (type != null && type.isNotEmpty) params['referral_type'] = type;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        clinicId,
        receptionistId,
        referralType,
      ];
}
