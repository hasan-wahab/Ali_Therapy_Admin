import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';
import '../entities/therapy_sessions_entity.dart';
import '../repositories/therapy_sessions_repository.dart';

// ============================================================
// GET THERAPYSESSIONS USE CASE
// ------------------------------------------------------------
// One job: fetch therapy sessions data.
// ============================================================

class GetTherapySessionsUseCase extends UseCase<TherapySessionsEntity, NoParams> {
  final TherapySessionsRepository repository;

  GetTherapySessionsUseCase(this.repository);

  @override
  ResultFuture<TherapySessionsEntity> call(NoParams params) {
    return repository.getTherapySessions();
  }
}
