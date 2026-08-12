import '../../../domain/all_employees_domain/entities/employee_clinic_entity.dart';
import 'employee_json_helpers.dart';

// ============================================================
// EMPLOYEE CLINIC MODEL (Data)
// ------------------------------------------------------------
// JSON → EmployeeClinicEntity. Null fields become "_".
// ============================================================

class EmployeeClinicModel extends EmployeeClinicEntity {
  const EmployeeClinicModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    required super.colourCode,
    required super.createdBy,
    required super.updatedBy,
    required super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EmployeeClinicModel.fromJson(Map<String, dynamic> json) {
    return EmployeeClinicModel(
      id: EmployeeJsonHelpers.text(json['id']),
      name: EmployeeJsonHelpers.text(json['name']),
      location: EmployeeJsonHelpers.text(json['location']),
      description: EmployeeJsonHelpers.text(json['description']),
      colourCode: EmployeeJsonHelpers.text(json['colour_code']),
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
      'location': location,
      'description': description,
      'colour_code': colourCode,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  EmployeeClinicEntity toEntity() {
    return EmployeeClinicEntity(
      id: id,
      name: name,
      location: location,
      description: description,
      colourCode: colourCode,
      createdBy: createdBy,
      updatedBy: updatedBy,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
