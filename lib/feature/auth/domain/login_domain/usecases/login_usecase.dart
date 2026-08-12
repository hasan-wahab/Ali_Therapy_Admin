import 'package:equatable/equatable.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/login_entity.dart';
import '../repositories/auth_repository.dart';

// ============================================================
// LOGIN USE CASE
// ------------------------------------------------------------
// One job: login the admin user.
// ============================================================

class LoginUseCase extends UseCase<LoginEntity, LoginParams> {
  LoginUseCase(this.repository);

  final AuthRepository repository;

  @override
  ResultFuture<LoginEntity> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}

/// Input values for LoginUseCase.
class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
