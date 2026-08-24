import 'package:equatable/equatable.dart';

// ============================================================
// EDIT EMPLOYEE OPTION (Domain)
// ------------------------------------------------------------
// One dropdown item: { "id", "name" }
// ============================================================

class EditEmployeeOptionEntity extends Equatable {
  const EditEmployeeOptionEntity({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
