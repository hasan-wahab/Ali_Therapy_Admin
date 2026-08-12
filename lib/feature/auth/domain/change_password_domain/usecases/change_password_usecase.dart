import 'package:equatable/equatable.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';
import 'package:ali_therapy_admin/core/utils/typedefs.dart';

import '../entities/change_password_entity.dart';
import '../repositories/change_password_repository.dart';

// ============================================================
// CHANGE PASSWORD USE CASE
// ------------------------------------------------------------
// One job: change password with current + new password.
// Token goes in the header (Dio interceptor).
// ============================================================

class ChangePasswordParams extends Equatable {
  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });

  final String currentPassword;
  final String newPassword;

  @override
  List<Object?> get props => [currentPassword, newPassword];
}

class ChangePasswordUseCase
    extends UseCase<ChangePasswordEntity, ChangePasswordParams> {
  ChangePasswordUseCase(this.repository);

  final ChangePasswordRepository repository;

  @override
  ResultFuture<ChangePasswordEntity> call(ChangePasswordParams params) {
    return repository.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );
  }
}
