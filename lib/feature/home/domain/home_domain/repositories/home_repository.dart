import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_overview_query.dart';

// ============================================================
// HOME REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class HomeRepository {
  ResultFuture<DashboardEntity> getDashboard({
    required DashboardOverviewQuery query,
  });
}
