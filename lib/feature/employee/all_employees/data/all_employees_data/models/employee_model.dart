import '../../../domain/all_employees_domain/entities/employee_entity.dart';
import 'employee_json_helpers.dart';

// ============================================================
// EMPLOYEE MODEL (Data)
// ------------------------------------------------------------
// Parses one item from employees-list card API.
// Any null / empty string → "_" (see EmployeeJsonHelpers.text).
// ============================================================

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required super.id,
    required super.imageUrl,
    required super.name,
    required super.email,
    required super.phone,
    required super.cnic,
    required super.employeeId,
    required super.joinedDate,
    required super.tenure,
    required super.roles,
    required super.shift,
    required super.isActive,
    required super.createdBy,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: EmployeeJsonHelpers.text(json['id']),
      imageUrl: EmployeeJsonHelpers.text(json['imageUrl'] ?? json['image_url']),
      name: EmployeeJsonHelpers.text(json['name']),
      email: EmployeeJsonHelpers.text(json['email']),
      phone: EmployeeJsonHelpers.text(json['phone']),
      cnic: EmployeeJsonHelpers.text(json['cnic']),
      employeeId: EmployeeJsonHelpers.text(
        json['employeeId'] ?? json['employee_id'],
      ),
      joinedDate: EmployeeJsonHelpers.text(
        json['joinedDate'] ?? json['joined_date'],
      ),
      tenure: EmployeeJsonHelpers.text(json['tenure']),
      roles: EmployeeJsonHelpers.stringList(json['roles']),
      shift: EmployeeJsonHelpers.text(json['shift']),
      isActive: EmployeeJsonHelpers.flag(
        json['isActive'] ?? json['is_active'],
      ),
      createdBy: EmployeeJsonHelpers.text(
        json['createdBy'] ?? json['created_by'],
      ),
    );
  }

  /// Parse a JSON array of employees.
  static List<EmployeeModel> listFromJson(dynamic rawList) {
    final list = EmployeeJsonHelpers.listOrEmpty(rawList);
    final employees = <EmployeeModel>[];

    for (final item in list) {
      final map = EmployeeJsonHelpers.mapOrNull(item);
      if (map == null) continue;
      employees.add(EmployeeModel.fromJson(map));
    }

    return employees;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'employeeId': employeeId,
      'joinedDate': joinedDate,
      'tenure': tenure,
      'roles': roles,
      'shift': shift,
      'isActive': isActive,
      'createdBy': createdBy,
    };
  }

  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      imageUrl: imageUrl,
      name: name,
      email: email,
      phone: phone,
      cnic: cnic,
      employeeId: employeeId,
      joinedDate: joinedDate,
      tenure: tenure,
      roles: roles,
      shift: shift,
      isActive: isActive,
      createdBy: createdBy,
    );
  }
}
