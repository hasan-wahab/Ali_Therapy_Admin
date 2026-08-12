import 'package:equatable/equatable.dart';

import 'permission_entity.dart';
import 'role_entity.dart';
import 'user_entity.dart';

// ============================================================
// LOGIN ENTITY (Domain)
// ------------------------------------------------------------
// Full login "data" payload:
//   access_token + user + permissions + roles
// ============================================================

class LoginEntity extends Equatable {
  final String accessToken;
  final UserEntity user;
  final List<PermissionEntity> permissions;
  final List<RoleEntity> roles;

  const LoginEntity({
    required this.accessToken,
    required this.user,
    required this.permissions,
    required this.roles,
  });

  @override
  List<Object?> get props => [accessToken, user, permissions, roles];
}
