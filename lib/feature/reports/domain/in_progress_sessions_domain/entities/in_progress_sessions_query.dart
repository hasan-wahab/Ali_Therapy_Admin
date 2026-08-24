import 'package:equatable/equatable.dart';

// ============================================================
// IN-PROGRESS SESSIONS QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/reports/in-progress-sessions
// session_type: all | consultant | therapist
// ============================================================

/// Per-page dropdown (matches the web in-progress sessions report).
class InProgressSessionsPerPage {
  InProgressSessionsPerPage._();

  static const int defaultSize = 50;

  /// Large page size when user picks "All".
  static const int all = 10000;

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

class InProgressSessionsQuery extends Equatable {
  const InProgressSessionsQuery({
    this.search = '',
    this.sessionType = sessionTypeAll,
    this.clinicId,
    this.staffId,
    this.fromDate,
    this.toDate,
    this.perPage = InProgressSessionsPerPage.defaultSize,
    this.page = 1,
  });

  static const sessionTypeAll = 'all';
  static const sessionTypeConsultant = 'consultant';
  static const sessionTypeTherapist = 'therapist';

  final String search;
  final String sessionType;
  final int? clinicId;
  final int? staffId;
  final String? fromDate; // yyyy-MM-dd
  final String? toDate;
  final int perPage;
  final int page;

  InProgressSessionsQuery copyWith({
    String? search,
    String? sessionType,
    int? clinicId,
    int? staffId,
    String? fromDate,
    String? toDate,
    int? perPage,
    int? page,
    bool clearClinicId = false,
    bool clearStaffId = false,
    bool clearFromDate = false,
    bool clearToDate = false,
  }) {
    return InProgressSessionsQuery(
      search: search ?? this.search,
      sessionType: sessionType ?? this.sessionType,
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      staffId: clearStaffId ? null : (staffId ?? this.staffId),
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  InProgressSessionsQuery resetFilters() => InProgressSessionsQuery(
        search: search,
        perPage: perPage,
      );

  bool get hasActiveFilters {
    final type = sessionType.trim();
    return (type.isNotEmpty && type != sessionTypeAll) ||
        clinicId != null ||
        staffId != null ||
        fromDate != null ||
        toDate != null;
  }

  static const sessionTypeAllLabel = 'All In-Progress Sessions';
  static const sessionTypeConsultantLabel = 'Consultation';
  static const sessionTypeTherapistLabel = 'Therapy Session';

  static String labelForSessionType(String value) {
    switch (value) {
      case sessionTypeConsultant:
        return sessionTypeConsultantLabel;
      case sessionTypeTherapist:
        return sessionTypeTherapistLabel;
      default:
        return sessionTypeAllLabel;
    }
  }

  static String sessionTypeForLabel(String label) {
    switch (label) {
      case sessionTypeConsultantLabel:
        return sessionTypeConsultant;
      case sessionTypeTherapistLabel:
        return sessionTypeTherapist;
      default:
        return sessionTypeAll;
    }
  }

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (page > 1) params['page'] = page;
    if (perPage != InProgressSessionsPerPage.defaultSize) {
      params['per_page'] = perPage;
    }
    final type = sessionType.trim();
    if (type.isNotEmpty && type != sessionTypeAll) {
      params['session_type'] = type;
    }
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (clinicId != null) params['clinic_id'] = clinicId;
    if (staffId != null) params['staff_id'] = staffId;
    if (fromDate != null) params['from_date'] = fromDate;
    if (toDate != null) params['to_date'] = toDate;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        sessionType,
        clinicId,
        staffId,
        fromDate,
        toDate,
        perPage,
        page,
      ];
}
