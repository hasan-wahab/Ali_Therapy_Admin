import '../../../domain/package_attendance_domain/entities/package_attendance_entity.dart';

// ============================================================
// PACKAGEATTENDANCE MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class PackageAttendanceModel extends PackageAttendanceEntity {
  const PackageAttendanceModel({required super.id});

  factory PackageAttendanceModel.fromJson(Map<String, dynamic> json) {
    return PackageAttendanceModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  PackageAttendanceEntity toEntity() => PackageAttendanceEntity(id: id);
}
