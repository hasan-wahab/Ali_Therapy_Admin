import 'package:equatable/equatable.dart';

// ============================================================
// EMPLOYEE ENTITY (Domain)
// ------------------------------------------------------------
// One employee card from employees-list (paginated) API.
// String fields use "_" when API sends null (set in the Model).
// ============================================================

class EmployeeEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String name;
  final String email;
  final String phone;
  final String cnic;
  final String employeeId;
  final String joinedDate;
  final String tenure;
  final List<String> roles;
  final String shift;
  final bool isActive;
  final String createdBy;

  const EmployeeEntity({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.phone,
    required this.cnic,
    required this.employeeId,
    required this.joinedDate,
    required this.tenure,
    required this.roles,
    required this.shift,
    required this.isActive,
    required this.createdBy,
  });

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    name,
    email,
    phone,
    cnic,
    employeeId,
    joinedDate,
    tenure,
    roles,
    shift,
    isActive,
    createdBy,
  ];
}
