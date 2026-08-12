import '../../../domain/login_domain/entities/role_entity.dart';
import 'login_json_helpers.dart';

// ============================================================
// ROLE MODEL (Data)
// ------------------------------------------------------------
// Parses one entry from "data.roles": { "1": "Super Admin" }
// Null / empty → "_"
// ============================================================

class RoleModel extends RoleEntity {
  const RoleModel({required super.id, required super.name});

  factory RoleModel.fromEntry(dynamic key, dynamic value) {
    return RoleModel(
      id: LoginJsonHelpers.text(key),
      name: LoginJsonHelpers.text(value),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  RoleEntity toEntity() => RoleEntity(id: id, name: name);
}
