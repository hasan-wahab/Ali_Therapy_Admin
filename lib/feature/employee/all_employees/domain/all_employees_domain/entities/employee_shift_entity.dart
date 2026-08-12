import 'package:equatable/equatable.dart';

// ============================================================
// EMPLOYEE SHIFT ENTITY (Domain)
// ------------------------------------------------------------
// Nested "shift" object from one employee in the list.
// ============================================================

class EmployeeShiftEntity extends Equatable {
  final String id;
  final String name;
  final String category;
  final String startTime;
  final String endTime;
  final String createdBy;
  final String updatedBy;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  const EmployeeShiftEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.startTime,
    required this.endTime,
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
        category,
        startTime,
        endTime,
        createdBy,
        updatedBy,
        deletedAt,
        createdAt,
        updatedAt,
      ];
}
