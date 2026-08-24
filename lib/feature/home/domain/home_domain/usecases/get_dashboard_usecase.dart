import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_overview_query.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/repositories/home_repository.dart';

// ============================================================
// GET DASHBOARD USE CASE
// ------------------------------------------------------------
// Loads overview stats for the Home screen.
// ============================================================

class GetDashboardUseCase
    extends UseCase<DashboardEntity, DashboardOverviewQuery> {
  GetDashboardUseCase(this.repository);

  final HomeRepository repository;

  @override
  ResultFuture<DashboardEntity> call(DashboardOverviewQuery params) {
    return repository.getDashboard(query: params);
  }
}
