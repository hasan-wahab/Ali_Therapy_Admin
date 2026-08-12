import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_entity.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/repositories/home_repository.dart';

// ============================================================
// HOME REPOSITORY IMPLEMENTATION (Data)
// ------------------------------------------------------------
// Will call core/datasources/home when dashboard API is ready.
// Not registered in DI yet — home UI uses sample widgets only.
// ============================================================

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl();

  @override
  ResultFuture<DashboardEntity> getDashboard() async {
    // TODO: Wire HomeRemoteDataSource + map DashboardModel → Entity.
    return Result.failure(
      const ServerFailure('Dashboard API not integrated yet.'),
    );
  }
}
