import 'package:equatable/equatable.dart';

// ============================================================
// EMPLOYEE FILTER OPTION ENTITY (Domain)
// ------------------------------------------------------------
// One dropdown item from employees filter meta API:
//   { "id": 18, "name": "Accountant" }
// Status also has optional "value" (0 / 1).
// ============================================================

class EmployeeFilterOptionEntity extends Equatable {
  final String id;
  final String name;

  /// Used by status options (Active=1, Inactive=0). Null for others.
  final int? value;

  const EmployeeFilterOptionEntity({
    required this.id,
    required this.name,
    this.value,
  });

  @override
  List<Object?> get props => [id, name, value];
}
