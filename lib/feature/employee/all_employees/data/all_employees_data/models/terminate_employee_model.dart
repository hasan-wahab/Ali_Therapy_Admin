import '../../../domain/all_employees_domain/entities/terminate_employee_entity.dart';

// ============================================================
// TERMINATE EMPLOYEE MODEL (Data)
// ------------------------------------------------------------
// Parses POST /employees/{id}/terminate:
// { "success": true, "message": "Employee terminated successfully." }
// ============================================================

class TerminateEmployeeModel extends TerminateEmployeeEntity {
  const TerminateEmployeeModel({required super.message});

  factory TerminateEmployeeModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return TerminateEmployeeModel(
      message: raw.isEmpty
          ? 'Employee terminated successfully.'
          : raw,
    );
  }

  TerminateEmployeeEntity toEntity() =>
      TerminateEmployeeEntity(message: message);
}
