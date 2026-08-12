import '../../../domain/all_employees_domain/entities/employee_department_entity.dart';
import 'employee_json_helpers.dart';

// ============================================================
// EMPLOYEE DEPARTMENT MODEL (Data)
// ------------------------------------------------------------
// JSON → EmployeeDepartmentEntity. Null fields become "_".
// ============================================================

class EmployeeDepartmentModel extends EmployeeDepartmentEntity {
  const EmployeeDepartmentModel({
    required super.id,
    required super.name,
    required super.createdBy,
    required super.updatedBy,
    required super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EmployeeDepartmentModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDepartmentModel(
      id: EmployeeJsonHelpers.text(json['id']),
      name: EmployeeJsonHelpers.text(json['name']),
      createdBy: EmployeeJsonHelpers.text(json['created_by']),
      updatedBy: EmployeeJsonHelpers.text(json['updated_by']),
      deletedAt: EmployeeJsonHelpers.text(json['deleted_at']),
      createdAt: EmployeeJsonHelpers.text(json['created_at']),
      updatedAt: EmployeeJsonHelpers.text(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  EmployeeDepartmentEntity toEntity() {
    return EmployeeDepartmentEntity(
      id: id,
      name: name,
      createdBy: createdBy,
      updatedBy: updatedBy,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
