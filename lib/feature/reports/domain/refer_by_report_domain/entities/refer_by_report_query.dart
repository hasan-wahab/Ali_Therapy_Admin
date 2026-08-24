import 'package:equatable/equatable.dart';

// ============================================================
// REFER BY REPORT QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/reports/refer-by
// ============================================================

/// Per-page dropdown (matches the web refer-by report).
class ReferByReportPerPage {
  ReferByReportPerPage._();

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

class ReferByReportQuery extends Equatable {
  const ReferByReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.clinicId,
    this.receptionistId,
    this.referralType,
    this.perPage = ReferByReportPerPage.defaultSize,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? clinicId;
  final int? receptionistId;
  final String? referralType;
  final int perPage;

  ReferByReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? clinicId,
    int? receptionistId,
    String? referralType,
    int? perPage,
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
      perPage: perPage ?? this.perPage,
    );
  }

  ReferByReportQuery resetFilters() => ReferByReportQuery(
        search: search,
        perPage: perPage,
      );

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
    if (perPage != ReferByReportPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
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
        perPage,
      ];
}
