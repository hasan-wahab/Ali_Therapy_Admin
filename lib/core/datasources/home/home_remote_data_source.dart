import 'package:ali_therapy_admin/feature/home/data/home_data/models/dashboard_model.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_overview_query.dart';

// ============================================================
// HOME REMOTE DATA SOURCE (contract)
// ------------------------------------------------------------
// GET /api/admin/dashboard/overview
// ============================================================

abstract class HomeRemoteDataSource {
  Future<DashboardModel> getOverview({
    required DashboardOverviewQuery query,
  });
}
