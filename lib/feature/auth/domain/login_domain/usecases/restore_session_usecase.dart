import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

// ============================================================
// RESTORE SESSION USE CASE
// ------------------------------------------------------------
// One job: if token is saved on device, restore LoginEntity.
// Used when the app opens on the login screen.
// ============================================================

class RestoreSessionUseCase extends UseCase<LoginEntity?, NoParams> {
  RestoreSessionUseCase(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<LoginEntity?> call(NoParams params) {
    return repository.restoreSession();
  }
}
