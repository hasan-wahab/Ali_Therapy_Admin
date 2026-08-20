import '../../../domain/all_employees_domain/entities/assign_employee_biometric_id_entity.dart';

// ============================================================
// ASSIGN EMPLOYEE BIOMETRIC ID MODEL (Data)
// ------------------------------------------------------------
// Parses POST /employees/{id}/assign-biometric-id:
// { "success": true, "message": "..." }
// ============================================================

class AssignEmployeeBiometricIdModel extends AssignEmployeeBiometricIdEntity {
  const AssignEmployeeBiometricIdModel({required super.message});

  factory AssignEmployeeBiometricIdModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return AssignEmployeeBiometricIdModel(
      message: raw.isEmpty
          ? 'Biometric ID assigned successfully.'
          : raw,
    );
  }

  AssignEmployeeBiometricIdEntity toEntity() =>
      AssignEmployeeBiometricIdEntity(message: message);
}
