import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';

// ============================================================
// HOME REPOSITORY CONTRACT (Domain)
// ============================================================

abstract class HomeRepository {
  ResultFuture<DashboardEntity> getDashboard();
}
