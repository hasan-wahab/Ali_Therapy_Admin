import '../../../domain/all_employees_domain/entities/employee_shift_entity.dart';
import 'employee_json_helpers.dart';

// ============================================================
// EMPLOYEE SHIFT MODEL (Data)
// ------------------------------------------------------------
// JSON → EmployeeShiftEntity. Null fields become "_".
// ============================================================

class EmployeeShiftModel extends EmployeeShiftEntity {
  const EmployeeShiftModel({
    required super.id,
    required super.name,
    required super.category,
    required super.startTime,
    required super.endTime,
    required super.createdBy,
    required super.updatedBy,
    required super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EmployeeShiftModel.fromJson(Map<String, dynamic> json) {
    return EmployeeShiftModel(
      id: EmployeeJsonHelpers.text(json['id']),
      name: EmployeeJsonHelpers.text(json['name']),
      category: EmployeeJsonHelpers.text(json['category']),
      startTime: EmployeeJsonHelpers.text(json['start_time']),
      endTime: EmployeeJsonHelpers.text(json['end_time']),
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
      'category': category,
      'start_time': startTime,
      'end_time': endTime,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  EmployeeShiftEntity toEntity() {
    return EmployeeShiftEntity(
      id: id,
      name: name,
      category: category,
      startTime: startTime,
      endTime: endTime,
      createdBy: createdBy,
      updatedBy: updatedBy,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
