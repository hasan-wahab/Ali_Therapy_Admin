import '../../../domain/all_employees_domain/entities/employee_entity.dart';
import 'employee_clinic_model.dart';
import 'employee_department_model.dart';
import 'employee_designation_model.dart';
import 'employee_json_helpers.dart';
import 'employee_shift_model.dart';

// ============================================================
// EMPLOYEE MODEL (Data)
// ------------------------------------------------------------
// Parses one item from the all-employees API list.
// Any null / empty field → "_" (see EmployeeJsonHelpers.text).
// ============================================================

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.emailVerifiedAt,
    required super.profilePicture,
    required super.isLogin,
    required super.userType,
    required super.createdBy,
    required super.updatedBy,
    required super.deletedAt,
    required super.createdAt,
    required super.updatedAt,
    required super.clinicId,
    required super.roomId,
    required super.departmentId,
    required super.designationId,
    required super.shiftId,
    required super.phone,
    required super.cnic,
    required super.deviceId,
    super.department,
    super.designation,
    super.shift,
    super.clinic,
    super.detail,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final departmentJson = EmployeeJsonHelpers.mapOrNull(json['department']);
    final designationJson = EmployeeJsonHelpers.mapOrNull(json['designation']);
    final shiftJson = EmployeeJsonHelpers.mapOrNull(json['shift']);
    final clinicJson = EmployeeJsonHelpers.mapOrNull(json['clinic']);

    return EmployeeModel(
      id: EmployeeJsonHelpers.text(json['id']),
      name: EmployeeJsonHelpers.text(json['name']),
      username: EmployeeJsonHelpers.text(json['username']),
      email: EmployeeJsonHelpers.text(json['email']),
      emailVerifiedAt: EmployeeJsonHelpers.text(json['email_verified_at']),
      profilePicture: EmployeeJsonHelpers.text(json['profile_picture']),
      isLogin: EmployeeJsonHelpers.text(json['is_login']),
      userType: EmployeeJsonHelpers.text(json['user_type']),
      createdBy: EmployeeJsonHelpers.text(json['created_by']),
      updatedBy: EmployeeJsonHelpers.text(json['updated_by']),
      deletedAt: EmployeeJsonHelpers.text(json['deleted_at']),
      createdAt: EmployeeJsonHelpers.text(json['created_at']),
      updatedAt: EmployeeJsonHelpers.text(json['updated_at']),
      clinicId: EmployeeJsonHelpers.text(json['clinic_id']),
      roomId: EmployeeJsonHelpers.text(json['room_id']),
      departmentId: EmployeeJsonHelpers.text(json['department_id']),
      designationId: EmployeeJsonHelpers.text(json['designation_id']),
      shiftId: EmployeeJsonHelpers.text(json['shift_id']),
      phone: EmployeeJsonHelpers.text(json['phone']),
      cnic: EmployeeJsonHelpers.text(json['cnic']),
      deviceId: EmployeeJsonHelpers.text(json['device_id']),
      department: departmentJson == null
          ? null
          : EmployeeDepartmentModel.fromJson(departmentJson),
      designation: designationJson == null
          ? null
          : EmployeeDesignationModel.fromJson(designationJson),
      shift: shiftJson == null ? null : EmployeeShiftModel.fromJson(shiftJson),
      clinic: clinicJson == null
          ? null
          : EmployeeClinicModel.fromJson(clinicJson),
      detail: EmployeeJsonHelpers.mapOrNull(json['detail']),
    );
  }

  /// Parse a JSON array of employees (API list body or data[]).
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
      'name': name,
      'username': username,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'profile_picture': profilePicture,
      'is_login': isLogin,
      'user_type': userType,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'clinic_id': clinicId,
      'room_id': roomId,
      'department_id': departmentId,
      'designation_id': designationId,
      'shift_id': shiftId,
      'phone': phone,
      'cnic': cnic,
      'device_id': deviceId,
      'department': department is EmployeeDepartmentModel
          ? (department as EmployeeDepartmentModel).toJson()
          : null,
      'designation': designation is EmployeeDesignationModel
          ? (designation as EmployeeDesignationModel).toJson()
          : null,
      'shift': shift is EmployeeShiftModel
          ? (shift as EmployeeShiftModel).toJson()
          : null,
      'clinic': clinic is EmployeeClinicModel
          ? (clinic as EmployeeClinicModel).toJson()
          : null,
      'detail': detail,
    };
  }

  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      name: name,
      username: username,
      email: email,
      emailVerifiedAt: emailVerifiedAt,
      profilePicture: profilePicture,
      isLogin: isLogin,
      userType: userType,
      createdBy: createdBy,
      updatedBy: updatedBy,
      deletedAt: deletedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      clinicId: clinicId,
      roomId: roomId,
      departmentId: departmentId,
      designationId: designationId,
      shiftId: shiftId,
      phone: phone,
      cnic: cnic,
      deviceId: deviceId,
      department: department is EmployeeDepartmentModel
          ? (department as EmployeeDepartmentModel).toEntity()
          : department,
      designation: designation is EmployeeDesignationModel
          ? (designation as EmployeeDesignationModel).toEntity()
          : designation,
      shift: shift is EmployeeShiftModel
          ? (shift as EmployeeShiftModel).toEntity()
          : shift,
      clinic: clinic is EmployeeClinicModel
          ? (clinic as EmployeeClinicModel).toEntity()
          : clinic,
      detail: detail,
    );
  }
}
