import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/repositories/home_repository.dart';

// ============================================================
// GET DASHBOARD USE CASE
// ============================================================

class GetDashboardUseCase extends UseCase<DashboardEntity, NoParams> {
  final HomeRepository repository;

  GetDashboardUseCase(this.repository);

  @override
  ResultFuture<DashboardEntity> call(NoParams params) {
    return repository.getDashboard();
  }
}
