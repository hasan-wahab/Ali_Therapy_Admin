import '../../../domain/all_employees_domain/entities/employees_page_entity.dart';
import 'employee_json_helpers.dart';
import 'employee_model.dart';

// ============================================================
// EMPLOYEES PAGE MODEL (Data)
// ------------------------------------------------------------
// Parses Laravel paginate JSON:
//   { current_page, data: [...], last_page, per_page, total, ... }
// ============================================================

class EmployeesPageModel extends EmployeesPageEntity {
  const EmployeesPageModel({
    required super.employees,
    required super.currentPage,
    required super.lastPage,
    required super.perPage,
    required super.total,
  });

  factory EmployeesPageModel.fromJson(Map<String, dynamic> json) {
    final employees = EmployeeModel.listFromJson(json['data']);

    return EmployeesPageModel(
      employees: employees,
      currentPage: _intOf(json['current_page'], fallback: 1),
      lastPage: _intOf(json['last_page'], fallback: 1),
      perPage: _intOf(json['per_page'], fallback: employees.length),
      total: _intOf(json['total'], fallback: employees.length),
    );
  }

  /// Build a single-page result from a raw list (no paginator).
  factory EmployeesPageModel.fromList(List<EmployeeModel> employees) {
    return EmployeesPageModel(
      employees: employees,
      currentPage: 1,
      lastPage: 1,
      perPage: employees.length,
      total: employees.length,
    );
  }

  EmployeesPageEntity toEntity() {
    return EmployeesPageEntity(
      employees: employees
          .map(
            (e) => e is EmployeeModel ? e.toEntity() : e,
          )
          .toList(),
      currentPage: currentPage,
      lastPage: lastPage,
      perPage: perPage,
      total: total,
    );
  }

  static int _intOf(dynamic value, {required int fallback}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(EmployeeJsonHelpers.text(value)) ?? fallback;
  }
}
