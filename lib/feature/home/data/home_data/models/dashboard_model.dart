import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';

// ============================================================
// DASHBOARD MODEL (Data)
// ============================================================

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.totalUsers,
    required super.totalAppointments,
    required super.pendingRequests,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalUsers: _asInt(json['total_users'] ?? json['totalUsers']),
      totalAppointments:
          _asInt(json['total_appointments'] ?? json['totalAppointments']),
      pendingRequests:
          _asInt(json['pending_requests'] ?? json['pendingRequests']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_users': totalUsers,
      'total_appointments': totalAppointments,
      'pending_requests': pendingRequests,
    };
  }

  DashboardEntity toEntity() {
    return DashboardEntity(
      totalUsers: totalUsers,
      totalAppointments: totalAppointments,
      pendingRequests: pendingRequests,
    );
  }

  static int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
