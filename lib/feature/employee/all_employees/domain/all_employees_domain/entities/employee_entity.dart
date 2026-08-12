import 'package:equatable/equatable.dart';

import 'employee_clinic_entity.dart';
import 'employee_department_entity.dart';
import 'employee_designation_entity.dart';
import 'employee_shift_entity.dart';

// ============================================================
// EMPLOYEE ENTITY (Domain)
// ------------------------------------------------------------
// One employee from the all-employees API list.
// String fields use "_" when API sends null (set in the Model).
// ============================================================

class EmployeeEntity extends Equatable {
  final String id;
  final String name;
  final String username;
  final String email;
  final String emailVerifiedAt;
  final String profilePicture;
  final String isLogin;
  final String userType;
  final String createdBy;
  final String updatedBy;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;
  final String clinicId;
  final String roomId;
  final String departmentId;
  final String designationId;
  final String shiftId;
  final String phone;
  final String cnic;
  final String deviceId;

  /// Nested objects — null when API sends null.
  final EmployeeDepartmentEntity? department;
  final EmployeeDesignationEntity? designation;
  final EmployeeShiftEntity? shift;
  final EmployeeClinicEntity? clinic;

  /// Extra field sometimes present on incomplete employees.
  final Map<String, dynamic>? detail;

  const EmployeeEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.profilePicture,
    required this.isLogin,
    required this.userType,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.clinicId,
    required this.roomId,
    required this.departmentId,
    required this.designationId,
    required this.shiftId,
    required this.phone,
    required this.cnic,
    required this.deviceId,
    this.department,
    this.designation,
    this.shift,
    this.clinic,
    this.detail,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    emailVerifiedAt,
    profilePicture,
    isLogin,
    userType,
    createdBy,
    updatedBy,
    deletedAt,
    createdAt,
    updatedAt,
    clinicId,
    roomId,
    departmentId,
    designationId,
    shiftId,
    phone,
    cnic,
    deviceId,
    department,
    designation,
    shift,
    clinic,
    detail,
  ];
}
