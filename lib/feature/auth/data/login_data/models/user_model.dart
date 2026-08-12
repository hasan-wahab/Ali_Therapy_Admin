import '../../../domain/login_domain/entities/user_entity.dart';
import 'clinic_model.dart';
import 'login_json_helpers.dart';

// ============================================================
// USER MODEL (Data)
// ------------------------------------------------------------
// Parses API "data.user".
// Any null / empty field → "_" (see LoginJsonHelpers.text).
// ============================================================

class UserModel extends UserEntity {
  const UserModel({
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
    super.clinic,
    super.room,
    super.department,
    super.designation,
    super.shift,
    super.employee,
    super.detail,
    super.token,
  });

  /// [accessToken] comes from parent "data.access_token" (not inside user JSON).
  factory UserModel.fromJson(
    Map<String, dynamic> json, {
    String accessToken = '',
  }) {
    final clinicJson = LoginJsonHelpers.mapOrNull(json['clinic']);

    return UserModel(
      id: LoginJsonHelpers.text(json['id']),
      name: LoginJsonHelpers.text(json['name']),
      username: LoginJsonHelpers.text(json['username']),
      email: LoginJsonHelpers.text(json['email']),
      emailVerifiedAt: LoginJsonHelpers.text(json['email_verified_at']),
      profilePicture: LoginJsonHelpers.text(json['profile_picture']),
      isLogin: LoginJsonHelpers.text(json['is_login']),
      userType: LoginJsonHelpers.text(json['user_type']),
      createdBy: LoginJsonHelpers.text(json['created_by']),
      updatedBy: LoginJsonHelpers.text(json['updated_by']),
      deletedAt: LoginJsonHelpers.text(json['deleted_at']),
      createdAt: LoginJsonHelpers.text(json['created_at']),
      updatedAt: LoginJsonHelpers.text(json['updated_at']),
      clinicId: LoginJsonHelpers.text(json['clinic_id']),
      roomId: LoginJsonHelpers.text(json['room_id']),
      departmentId: LoginJsonHelpers.text(json['department_id']),
      designationId: LoginJsonHelpers.text(json['designation_id']),
      shiftId: LoginJsonHelpers.text(json['shift_id']),
      phone: LoginJsonHelpers.text(json['phone']),
      cnic: LoginJsonHelpers.text(json['cnic']),
      deviceId: LoginJsonHelpers.text(json['device_id']),
      clinic: clinicJson == null ? null : ClinicModel.fromJson(clinicJson),
      room: LoginJsonHelpers.mapOrNull(json['room']),
      department: LoginJsonHelpers.mapOrNull(json['department']),
      designation: LoginJsonHelpers.mapOrNull(json['designation']),
      shift: LoginJsonHelpers.mapOrNull(json['shift']),
      employee: LoginJsonHelpers.mapOrNull(json['employee']),
      detail: LoginJsonHelpers.mapOrNull(json['detail']),
      token: accessToken.trim().isEmpty ? '_' : accessToken.trim(),
    );
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
      'clinic': clinic is ClinicModel
          ? (clinic as ClinicModel).toJson()
          : clinic,
      'room': room,
      'department': department,
      'designation': designation,
      'shift': shift,
      'employee': employee,
      'detail': detail,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
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
      clinic: clinic is ClinicModel
          ? (clinic as ClinicModel).toEntity()
          : clinic,
      room: room,
      department: department,
      designation: designation,
      shift: shift,
      employee: employee,
      detail: detail,
      token: token,
    );
  }
}
