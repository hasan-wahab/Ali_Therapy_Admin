import 'package:equatable/equatable.dart';

// ============================================================
// PERMISSION ENTITY (Domain)
// ------------------------------------------------------------
// One permission string from login "data.permissions".
// Example: "view dashboard"
// ============================================================

class PermissionEntity extends Equatable {
  /// Permission name (null/empty from API → "_").
  final String name;

  const PermissionEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
