import '../../../domain/login_domain/entities/permission_entity.dart';
import 'login_json_helpers.dart';

// ============================================================
// PERMISSION MODEL (Data)
// ------------------------------------------------------------
// Parses one item from "data.permissions" array.
// Null / empty → "_"
// ============================================================

class PermissionModel extends PermissionEntity {
  const PermissionModel({required super.name});

  factory PermissionModel.fromJson(dynamic json) {
    // API sends plain strings: "view dashboard"
    return PermissionModel(name: LoginJsonHelpers.text(json));
  }

  /// If backend ever sends { "name": "..." }.
  factory PermissionModel.fromMap(Map<String, dynamic> json) {
    return PermissionModel(
      name: LoginJsonHelpers.text(json['name'] ?? json['permission']),
    );
  }

  Map<String, dynamic> toJson() => {'name': name};

  PermissionEntity toEntity() => PermissionEntity(name: name);
}
