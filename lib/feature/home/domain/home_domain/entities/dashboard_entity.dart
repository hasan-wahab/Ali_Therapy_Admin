import 'package:equatable/equatable.dart';

// ============================================================
// DASHBOARD ENTITY (Domain)
// ------------------------------------------------------------

class DashboardEntity extends Equatable {
  final int totalUsers;
  final int totalAppointments;
  final int pendingRequests;

  const DashboardEntity({
    required this.totalUsers,
    required this.totalAppointments,
    required this.pendingRequests,
  });

  @override
  List<Object?> get props => [
        totalUsers,
        totalAppointments,
        pendingRequests,
      ];
}
