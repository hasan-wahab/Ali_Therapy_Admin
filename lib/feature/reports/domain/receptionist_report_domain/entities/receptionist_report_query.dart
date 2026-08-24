import 'package:equatable/equatable.dart';

// ============================================================
// RECEPTIONIST REPORT QUERY (Domain)
// ------------------------------------------------------------
// All query params for GET /api/admin/reports/receptionist
// ============================================================

/// Per-page dropdown (same options as Discount Report / web).
class ReceptionistReportPerPage {
  ReceptionistReportPerPage._();

  static const int defaultSize = 10;

  /// Large page size when user picks "All".
  static const int all = 10000;

  static const String allLabel = 'All';

  static List<String> get dropdownLabels => [
        '10',
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

/// Visit type dropdown (matches web "All Types").
class ReceptionistReportType {
  ReceptionistReportType._();

  static const String all = '';
  static const String allLabel = 'All Types';

  static const String consultation = 'consultation';
  static const String therapy = 'therapy';
  static const String reconsultation = 'reconsultation';

  static const String consultationLabel = 'Consultation';
  static const String therapyLabel = 'Therapy Session';
  static const String reconsultationLabel = 'Reconsultation';

  static List<String> get dropdownLabels => [
        allLabel,
        consultationLabel,
        therapyLabel,
        reconsultationLabel,
      ];

  static String labelFor(String value) {
    switch (value.trim().toLowerCase()) {
      case consultation:
        return consultationLabel;
      case therapy:
      case 'therapy_session':
      case 'therapy session':
        return therapyLabel;
      case reconsultation:
        return reconsultationLabel;
      default:
        return allLabel;
    }
  }

  static String valueForLabel(String label) {
    switch (label) {
      case consultationLabel:
        return consultation;
      case therapyLabel:
        return therapy;
      case reconsultationLabel:
        return reconsultation;
      default:
        return all;
    }
  }

  static bool isAll(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty || trimmed.toLowerCase() == 'all';
  }
}

class ReceptionistReportQuery extends Equatable {
  const ReceptionistReportQuery({
    this.search = '',
    this.fromDate,
    this.toDate,
    this.receptionistId,
    this.clinicId,
    this.type = ReceptionistReportType.all,
    this.perPage = ReceptionistReportPerPage.defaultSize,
    this.page = 1,
  });

  final String search;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int? receptionistId;
  final int? clinicId;
  final String type;
  final int perPage;
  final int page;

  ReceptionistReportQuery copyWith({
    String? search,
    String? fromDate,
    String? toDate,
    int? receptionistId,
    int? clinicId,
    String? type,
    int? perPage,
    int? page,
    bool clearFromDate = false,
    bool clearToDate = false,
    bool clearReceptionistId = false,
    bool clearClinicId = false,
    bool clearType = false,
  }) {
    return ReceptionistReportQuery(
      search: search ?? this.search,
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      receptionistId:
          clearReceptionistId ? null : (receptionistId ?? this.receptionistId),
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      type: clearType ? ReceptionistReportType.all : (type ?? this.type),
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
      clinicId != null ||
      !ReceptionistReportType.isAll(type);

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    if (perPage != ReceptionistReportPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    if (receptionistId != null) params['receptionist_id'] = receptionistId;
    if (clinicId != null) params['clinic_id'] = clinicId;
    if (!ReceptionistReportType.isAll(type)) params['type'] = type;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        fromDate,
        toDate,
        receptionistId,
        clinicId,
        type,
        perPage,
        page,
      ];
}
