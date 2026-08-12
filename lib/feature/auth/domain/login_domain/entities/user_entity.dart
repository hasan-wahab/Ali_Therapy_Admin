import 'package:equatable/equatable.dart';

import 'clinic_entity.dart';

// ============================================================
// USER ENTITY (Domain)
// ------------------------------------------------------------
// Logged-in user from API "data.user".
// String fields use "_" when API sends null (set in the Model).
// ============================================================

class UserEntity extends Equatable {
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

  /// Nested clinic (null when API sends null).
  final ClinicEntity? clinic;

  /// Extra nested objects — kept as raw maps for now (often null).
  /// UI can show "_" when null.
  final Map<String, dynamic>? room;
  final Map<String, dynamic>? department;
  final Map<String, dynamic>? designation;
  final Map<String, dynamic>? shift;
  final Map<String, dynamic>? employee;
  final Map<String, dynamic>? detail;

  /// Access token copied from login "data.access_token" (handy for AuthBloc).
  final String token;

  const UserEntity({
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
    this.clinic,
    this.room,
    this.department,
    this.designation,
    this.shift,
    this.employee,
    this.detail,
    this.token = '_',
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
        clinic,
        room,
        department,
        designation,
        shift,
        employee,
        detail,
        token,
      ];
}
