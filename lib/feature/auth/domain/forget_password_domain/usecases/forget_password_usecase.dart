import 'package:equatable/equatable.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/forget_password_entity.dart';
import '../repositories/forget_password_repository.dart';

// ============================================================
// FORGET PASSWORD USE CASE
// ------------------------------------------------------------
// One job: request a password reset for an email.
// ============================================================

class ForgetPasswordParams extends Equatable {
  const ForgetPasswordParams({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class ForgetPasswordUseCase
    extends UseCase<ForgetPasswordEntity, ForgetPasswordParams> {
  ForgetPasswordUseCase(this.repository);

  final ForgetPasswordRepository repository;

  @override
  ResultFuture<ForgetPasswordEntity> call(ForgetPasswordParams params) {
    return repository.requestReset(email: params.email);
  }
}
