import '../../../domain/all_employees_domain/entities/assign_employee_device_id_entity.dart';

// ============================================================
// ASSIGN EMPLOYEE DEVICE ID MODEL (Data)
// ------------------------------------------------------------
// Parses POST /employees/{id}/assign-device-id:
// { "success": true, "message": "..." }
// ============================================================

class AssignEmployeeDeviceIdModel extends AssignEmployeeDeviceIdEntity {
  const AssignEmployeeDeviceIdModel({required super.message});

  factory AssignEmployeeDeviceIdModel.fromJson(Map<String, dynamic> json) {
    final raw = json['message']?.toString().trim() ?? '';
    return AssignEmployeeDeviceIdModel(
      message: raw.isEmpty ? 'Device ID assigned successfully.' : raw,
    );
  }

  AssignEmployeeDeviceIdEntity toEntity() =>
      AssignEmployeeDeviceIdEntity(message: message);
}
