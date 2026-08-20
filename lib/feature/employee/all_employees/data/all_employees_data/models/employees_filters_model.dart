import '../../../domain/all_employees_domain/entities/employees_filters_entity.dart';
import 'employee_filter_option_model.dart';
import 'employee_json_helpers.dart';

// ============================================================
// EMPLOYEES FILTERS MODEL (Data)
// ------------------------------------------------------------
// Parses filter meta "data" object:
// {
//   "roles": [ { "id", "name" } ],
//   "designations": [...],
//   "clinics": [...],
//   "departments": [...],
//   "shifts": [...],
//   "statuses": [ { "id", "name", "value" } ]
// }
// ============================================================

class EmployeesFiltersModel extends EmployeesFiltersEntity {
  const EmployeesFiltersModel({
    required super.roles,
    required super.designations,
    required super.clinics,
    required super.departments,
    required super.shifts,
    required super.statuses,
  });

  /// Parse the inner "data" map from the API response.
  factory EmployeesFiltersModel.fromJson(Map<String, dynamic> json) {
    return EmployeesFiltersModel(
      roles: EmployeeFilterOptionModel.listFromJson(json['roles']),
      designations: EmployeeFilterOptionModel.listFromJson(
        json['designations'],
      ),
      clinics: EmployeeFilterOptionModel.listFromJson(json['clinics']),
      departments: EmployeeFilterOptionModel.listFromJson(json['departments']),
      shifts: EmployeeFilterOptionModel.listFromJson(json['shifts']),
      statuses: EmployeeFilterOptionModel.listFromJson(json['statuses']),
    );
  }

  /// Parse full API body: { success, data: { roles, ... } } or just data map.
  factory EmployeesFiltersModel.fromResponse(dynamic body) {
    final root = EmployeeJsonHelpers.mapOrNull(body);
    if (root == null) {
      return const EmployeesFiltersModel(
        roles: [],
        designations: [],
        clinics: [],
        departments: [],
        shifts: [],
        statuses: [],
      );
    }

    final data = EmployeeJsonHelpers.mapOrNull(root['data']) ?? root;
    return EmployeesFiltersModel.fromJson(data);
  }

  EmployeesFiltersEntity toEntity() {
    return EmployeesFiltersEntity(
      roles: roles
          .map((e) => e is EmployeeFilterOptionModel ? e.toEntity() : e)
          .toList(),
      designations: designations
          .map((e) => e is EmployeeFilterOptionModel ? e.toEntity() : e)
          .toList(),
      clinics: clinics
          .map((e) => e is EmployeeFilterOptionModel ? e.toEntity() : e)
          .toList(),
      departments: departments
          .map((e) => e is EmployeeFilterOptionModel ? e.toEntity() : e)
          .toList(),
      shifts: shifts
          .map((e) => e is EmployeeFilterOptionModel ? e.toEntity() : e)
          .toList(),
      statuses: statuses
          .map((e) => e is EmployeeFilterOptionModel ? e.toEntity() : e)
          .toList(),
    );
  }
}
