import '../../../domain/login_domain/entities/login_entity.dart';
import '../../../domain/login_domain/entities/permission_entity.dart';
import '../../../domain/login_domain/entities/role_entity.dart';
import 'login_json_helpers.dart';
import 'permission_model.dart';
import 'role_model.dart';
import 'user_model.dart';

// ============================================================
// LOGIN MODEL (Data)
// ------------------------------------------------------------
// Parses the full login API body:
// {
//   "success": true,
//   "status_code": 200,
//   "message": "...",
//   "data": {
//     "access_token": "...",
//     "user": { ... },
//     "permissions": [ "view dashboard", ... ],
//     "roles": { "1": "Super Admin" }
//   }
// }
//
// Null / empty values → "_" (via LoginJsonHelpers).
// ============================================================

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.accessToken,
    required super.user,
    required super.permissions,
    required super.roles,
  });

  /// Pass either the full response OR just the "data" map.
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final data = LoginJsonHelpers.mapOrNull(json['data']) ?? json;

    // Real token — never convert to "_"
    final accessToken = LoginJsonHelpers.requiredToken(data['access_token']);

    final userJson = LoginJsonHelpers.mapOrNull(data['user']);
    if (userJson == null) {
      throw const FormatException('Login response missing data.user');
    }

    final user = UserModel.fromJson(userJson, accessToken: accessToken);

    // permissions: [ "view dashboard", "view employee", ... ]
    final permissions = <PermissionModel>[];
    final rawPermissions = data['permissions'];
    if (rawPermissions is List) {
      for (final item in rawPermissions) {
        permissions.add(PermissionModel.fromJson(item));
      }
    }

    // roles: { "1": "Super Admin" }
    final roles = <RoleModel>[];
    final rawRoles = data['roles'];
    if (rawRoles is Map) {
      rawRoles.forEach((key, value) {
        roles.add(RoleModel.fromEntry(key, value));
      });
    }

    return LoginModel(
      accessToken: accessToken,
      user: user,
      permissions: permissions,
      roles: roles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'user': user is UserModel ? (user as UserModel).toJson() : null,
      'permissions': permissions
          .map((p) => p is PermissionModel ? p.name : p.name)
          .toList(),
      'roles': {
        for (final role in roles) role.id: role.name,
      },
    };
  }

  LoginEntity toEntity() {
    return LoginEntity(
      accessToken: accessToken,
      user: user is UserModel ? (user as UserModel).toEntity() : user,
      permissions: permissions
          .map(
            (p) =>
                p is PermissionModel ? p.toEntity() : PermissionEntity(name: p.name),
          )
          .toList(),
      roles: roles
          .map(
            (r) => r is RoleModel
                ? r.toEntity()
                : RoleEntity(id: r.id, name: r.name),
          )
          .toList(),
    );
  }
}
