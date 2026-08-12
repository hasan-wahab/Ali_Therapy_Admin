import 'package:equatable/equatable.dart';

// ============================================================
// EMPLOYEE DEPARTMENT ENTITY (Domain)
// ------------------------------------------------------------
// Nested "department" object from one employee in the list.
// ============================================================

class EmployeeDepartmentEntity extends Equatable {
  final String id;
  final String name;
  final String createdBy;
  final String updatedBy;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  const EmployeeDepartmentEntity({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        createdBy,
        updatedBy,
        deletedAt,
        createdAt,
        updatedAt,
      ];
}
