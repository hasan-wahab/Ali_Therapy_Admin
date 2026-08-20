import 'package:equatable/equatable.dart';

// ============================================================
// PACKAGE ATTENDANCE QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/reports/package-attendance
// ============================================================

class PackageAttendanceQuery extends Equatable {
  const PackageAttendanceQuery({
    this.search = '',
    this.clinicId,
    this.gender,
    this.therapistId,
    this.perPage = 15,
    this.page = 1,
  });

  final String search;
  final int? clinicId;
  final String? gender;
  final int? therapistId;
  final int perPage;
  final int page;

  PackageAttendanceQuery copyWith({
    String? search,
    int? clinicId,
    String? gender,
    int? therapistId,
    int? perPage,
    int? page,
    bool clearClinicId = false,
    bool clearGender = false,
    bool clearTherapistId = false,
  }) {
    return PackageAttendanceQuery(
      search: search ?? this.search,
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      gender: clearGender ? null : (gender ?? this.gender),
      therapistId: clearTherapistId ? null : (therapistId ?? this.therapistId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  PackageAttendanceQuery resetFilters() => PackageAttendanceQuery(
        search: search,
        perPage: perPage,
        page: 1,
      );

  bool get hasActiveFilters {
    final selectedGender = gender?.trim() ?? '';
    return clinicId != null ||
        selectedGender.isNotEmpty ||
        therapistId != null;
  }

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };
    final s = search.trim();
    if (s.isNotEmpty) params['search'] = s;
    if (clinicId != null) params['clinic_id'] = clinicId;
    final g = gender?.trim();
    if (g != null && g.isNotEmpty) params['gender'] = g;
    if (therapistId != null) params['therapist_id'] = therapistId;
    return params;
  }

  @override
  List<Object?> get props => [
        search,
        clinicId,
        gender,
        therapistId,
        perPage,
        page,
      ];
}
