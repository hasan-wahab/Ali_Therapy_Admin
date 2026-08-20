import '../../../domain/all_employees_domain/entities/change_employee_password_entity.dart';

// ============================================================
// CHANGE EMPLOYEE PASSWORD MODEL (Data)
// ------------------------------------------------------------
// Parses POST /employees/{id}/change-password:
// { "success": true, "message": "Password changed successfully for ..." }
// ============================================================

class ChangeEmployeePasswordModel extends ChangeEmployeePasswordEntity {
  const ChangeEmployeePasswordModel({required super.message});

  factory ChangeEmployeePasswordModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return ChangeEmployeePasswordModel(
      message: raw.isEmpty
          ? 'Password changed successfully.'
          : raw,
    );
  }

  ChangeEmployeePasswordEntity toEntity() =>
      ChangeEmployeePasswordEntity(message: message);
}
