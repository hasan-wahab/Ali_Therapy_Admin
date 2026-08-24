import '../../../domain/all_employees_domain/entities/delete_employee_entity.dart';

// ============================================================
// DELETE EMPLOYEE MODEL (Data)
// ------------------------------------------------------------
// Parses DELETE /employees/{id}:
// { "success": true, "message": "Employee deleted successfully." }
// ============================================================

class DeleteEmployeeModel extends DeleteEmployeeEntity {
  const DeleteEmployeeModel({required super.message});

  factory DeleteEmployeeModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return DeleteEmployeeModel(
      message: raw.isEmpty ? 'Employee deleted successfully.' : raw,
    );
  }

  DeleteEmployeeEntity toEntity() => DeleteEmployeeEntity(message: message);
}
