import '../../../domain/user_activity_report_domain/entities/user_activity_report_entity.dart';

// ============================================================
// USERACTIVITYREPORT MODEL (Data)
// ------------------------------------------------------------
// Same idea as UserModel: JSON helpers live here.
// ============================================================

class UserActivityReportModel extends UserActivityReportEntity {
  const UserActivityReportModel({required super.id});

  factory UserActivityReportModel.fromJson(Map<String, dynamic> json) {
    return UserActivityReportModel(id: json['id']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() => {'id': id};

  UserActivityReportEntity toEntity() => UserActivityReportEntity(id: id);
}
