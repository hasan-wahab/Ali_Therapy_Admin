import '../../../domain/all_employees_domain/entities/toggle_status_entity.dart';
import 'employee_json_helpers.dart';

// ============================================================
// TOGGLE STATUS MODEL (Data)
// ------------------------------------------------------------
// Parses POST /employees/{id}/toggle-status response:
// { "id", "name", "isActive", "status" }
// ============================================================

class ToggleStatusModel extends ToggleStatusEntity {
  const ToggleStatusModel({
    required super.id,
    required super.name,
    required super.isActive,
  });

  factory ToggleStatusModel.fromJson(Map<String, dynamic> json) {
    return ToggleStatusModel(
      id: EmployeeJsonHelpers.text(json['id']),
      name: EmployeeJsonHelpers.text(json['name']),
      isActive: EmployeeJsonHelpers.flag(
        json['isActive'] ?? json['is_active'],
      ),
    );
  }

  ToggleStatusEntity toEntity() =>
      ToggleStatusEntity(id: id, name: name, isActive: isActive);
}
