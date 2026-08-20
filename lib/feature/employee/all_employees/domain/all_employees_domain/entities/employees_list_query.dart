import 'package:equatable/equatable.dart';

// ============================================================
// EMPLOYEES LIST QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET employees-list:
//   status, search, clinic_id, department_id, designation_id,
//   shift_id, role_id, per_page, page
// ============================================================

/// Per-page dropdown options (matches web admin).
class EmployeesListPerPage {
  EmployeesListPerPage._();

  static const int defaultSize = 50;

  /// Large page size when user picks "All".
  static const int all = 10000;

  static const List<int> options = [50, 100, 200, 500, 1000];

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

class EmployeesListQuery extends Equatable {
  const EmployeesListQuery({
    this.search = '',
    this.status = 'all',
    this.clinicId,
    this.departmentId,
    this.designationId,
    this.shiftId,
    this.roleId,
    this.perPage = EmployeesListPerPage.defaultSize,
    this.page = 1,
  });

  /// Search by Name, Employee ID, Phone, CNIC, or Email.
  final String search;

  /// "1" Active, "0" Inactive, "all" both.
  final String status;

  final int? clinicId;
  final int? departmentId;
  final int? designationId;
  final int? shiftId;
  final int? roleId;
  final int perPage;
  final int page;

  EmployeesListQuery copyWith({
    String? search,
    String? status,
    int? clinicId,
    int? departmentId,
    int? designationId,
    int? shiftId,
    int? roleId,
    int? perPage,
    int? page,
    bool clearClinicId = false,
    bool clearDepartmentId = false,
    bool clearDesignationId = false,
    bool clearShiftId = false,
    bool clearRoleId = false,
  }) {
    return EmployeesListQuery(
      search: search ?? this.search,
      status: status ?? this.status,
      clinicId: clearClinicId ? null : (clinicId ?? this.clinicId),
      departmentId:
          clearDepartmentId ? null : (departmentId ?? this.departmentId),
      designationId:
          clearDesignationId ? null : (designationId ?? this.designationId),
      shiftId: clearShiftId ? null : (shiftId ?? this.shiftId),
      roleId: clearRoleId ? null : (roleId ?? this.roleId),
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
    );
  }

  /// Reset filters (keeps search). Status = all, per page = default.
  EmployeesListQuery resetFilters() {
    return EmployeesListQuery(
      search: search,
      perPage: EmployeesListPerPage.defaultSize,
      page: 1,
    );
  }

  /// True when clinic / role / status filters are applied.
  bool get hasActiveFilters =>
      status != 'all' ||
      clinicId != null ||
      departmentId != null ||
      designationId != null ||
      shiftId != null ||
      roleId != null;

  /// Dio query map — empty / null optionals are omitted.
  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{
      'page': page,
      'per_page': perPage,
    };

    final trimmedSearch = search.trim();
    if (trimmedSearch.isNotEmpty) {
      params['search'] = trimmedSearch;
    }

    if (status.isNotEmpty) {
      params['status'] = status;
    }

    if (clinicId != null) params['clinic_id'] = clinicId;
    if (departmentId != null) params['department_id'] = departmentId;
    if (designationId != null) params['designation_id'] = designationId;
    if (shiftId != null) params['shift_id'] = shiftId;
    if (roleId != null) params['role_id'] = roleId;

    return params;
  }

  @override
  List<Object?> get props => [
        search,
        status,
        clinicId,
        departmentId,
        designationId,
        shiftId,
        roleId,
        perPage,
        page,
      ];
}
