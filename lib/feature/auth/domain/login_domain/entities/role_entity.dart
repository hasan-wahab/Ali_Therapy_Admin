import 'package:equatable/equatable.dart';

// ============================================================
// ROLE ENTITY (Domain)
// ------------------------------------------------------------
// One role entry from login "data.roles".
// Example: id "1" → name "Super Admin"
// ============================================================

class RoleEntity extends Equatable {
  final String id;
  final String name;

  const RoleEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
