import 'package:equatable/equatable.dart';

import 'edit_employee_option_entity.dart';

// ============================================================
// EDIT EMPLOYEE OPTIONS (Domain)
// ------------------------------------------------------------
// Dropdown lists for the edit form.
// ============================================================

class EditEmployeeOptionsEntity extends Equatable {
  const EditEmployeeOptionsEntity({
    this.clinics = const [],
    this.rooms = const [],
    this.roles = const [],
    this.departments = const [],
    this.designations = const [],
    this.shifts = const [],
  });

  const EditEmployeeOptionsEntity.empty()
      : clinics = const [],
        rooms = const [],
        roles = const [],
        departments = const [],
        designations = const [],
        shifts = const [];

  final List<EditEmployeeOptionEntity> clinics;
  final List<EditEmployeeOptionEntity> rooms;
  final List<EditEmployeeOptionEntity> roles;
  final List<EditEmployeeOptionEntity> departments;
  final List<EditEmployeeOptionEntity> designations;
  final List<EditEmployeeOptionEntity> shifts;

  List<String> clinicNames({String current = ''}) =>
      _names(clinics, current);

  List<String> roomNames({String current = ''}) => _names(rooms, current);

  List<String> roleNames({String current = ''}) => _names(roles, current);

  List<String> departmentNames({String current = ''}) =>
      _names(departments, current);

  List<String> designationNames({String current = ''}) =>
      _names(designations, current);

  List<String> shiftNames({String current = ''}) => _names(shifts, current);

  String idForClinic(String? name) => _idFor(clinics, name);

  String idForRoom(String? name) => _idFor(rooms, name);

  String idForRole(String? name) => _idFor(roles, name);

  String idForDepartment(String? name) => _idFor(departments, name);

  String idForDesignation(String? name) => _idFor(designations, name);

  String idForShift(String? name) => _idFor(shifts, name);

  static List<String> _names(
    List<EditEmployeeOptionEntity> options,
    String current,
  ) {
    final names = [
      for (final option in options)
        if (option.name.trim().isNotEmpty) option.name,
    ];
    if (current.trim().isNotEmpty && !names.contains(current)) {
      return [current, ...names];
    }
    return names;
  }

  static String _idFor(
    List<EditEmployeeOptionEntity> options,
    String? name,
  ) {
    if (name == null || name.trim().isEmpty) return '';
    final wanted = name.trim().toLowerCase();
    for (final option in options) {
      if (option.name.trim().toLowerCase() == wanted) return option.id;
    }
    return '';
  }

  @override
  List<Object?> get props => [
        clinics,
        rooms,
        roles,
        departments,
        designations,
        shifts,
      ];
}
