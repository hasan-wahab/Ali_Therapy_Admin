import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../repositories/auth_repository.dart';

// ============================================================
// LOGOUT USE CASE
// ------------------------------------------------------------
// One job: logout the admin user.
// ============================================================

class LogoutUseCase extends UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  ResultVoid call(NoParams params) {
    return repository.logout();
  }
}
