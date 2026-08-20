part of 'all_employees_bloc.dart';

abstract class AllEmployeesEvent extends Equatable {
  const AllEmployeesEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load (page 1).
class AllEmployeesStarted extends AllEmployeesEvent {
  const AllEmployeesStarted();
}

/// Pull-to-refresh — reload page 1 (list stays visible).
class AllEmployeesRefreshed extends AllEmployeesEvent {
  const AllEmployeesRefreshed({required this.completer});

  final Completer<void> completer;

  @override
  List<Object?> get props => [completer];
}

/// Scroll near bottom — load next page and append.
class AllEmployeesLoadMore extends AllEmployeesEvent {
  const AllEmployeesLoadMore();
}

/// Search text changed (starts debounce; does not hit API yet).
class AllEmployeesSearchChanged extends AllEmployeesEvent {
  const AllEmployeesSearchChanged(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Debounced search ready → reload page 1.
class AllEmployeesSearchSubmitted extends AllEmployeesEvent {
  const AllEmployeesSearchSubmitted(this.search);

  final String search;

  @override
  List<Object?> get props => [search];
}

/// Toggle one employee's active / inactive status.
class AllEmployeesStatusToggled extends AllEmployeesEvent {
  const AllEmployeesStatusToggled({
    required this.employeeId,
    required this.newStatus,
  });

  final String employeeId;
  final bool newStatus;

  @override
  List<Object?> get props => [employeeId, newStatus];
}

/// Confirm terminate dialog → POST /employees/{id}/terminate
class AllEmployeesTerminated extends AllEmployeesEvent {
  const AllEmployeesTerminated({
    required this.employeeId,
    required this.reason,
    required this.date,
  });

  final String employeeId;
  final String reason;
  final String date;

  @override
  List<Object?> get props => [employeeId, reason, date];
}

/// Change password dialog → POST /employees/{id}/change-password
class AllEmployeesPasswordChanged extends AllEmployeesEvent {
  const AllEmployeesPasswordChanged({
    required this.employeeId,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  final String employeeId;
  final String newPassword;
  final String newPasswordConfirmation;

  @override
  List<Object?> get props => [
        employeeId,
        newPassword,
        newPasswordConfirmation,
      ];
}

/// Assign device ID dialog → POST /employees/{id}/assign-device-id
class AllEmployeesDeviceIdAssigned extends AllEmployeesEvent {
  const AllEmployeesDeviceIdAssigned({
    required this.employeeId,
    required this.deviceId,
  });

  final String employeeId;
  final int deviceId;

  @override
  List<Object?> get props => [employeeId, deviceId];
}

/// Assign biometric ID dialog → POST /employees/{id}/assign-biometric-id
class AllEmployeesBiometricIdAssigned extends AllEmployeesEvent {
  const AllEmployeesBiometricIdAssigned({
    required this.employeeId,
    required this.biometricId,
  });

  final String employeeId;
  final String biometricId;

  @override
  List<Object?> get props => [employeeId, biometricId];
}

/// One or more filter dropdowns changed → reload page 1 immediately.
class AllEmployeesFiltersApplied extends AllEmployeesEvent {
  const AllEmployeesFiltersApplied({
    this.status,
    this.clinicId,
    this.departmentId,
    this.designationId,
    this.shiftId,
    this.roleId,
    this.perPage,
    this.clearClinicId = false,
    this.clearDepartmentId = false,
    this.clearDesignationId = false,
    this.clearShiftId = false,
    this.clearRoleId = false,
    this.resetAll = false,
  });

  final String? status;
  final int? clinicId;
  final int? departmentId;
  final int? designationId;
  final int? shiftId;
  final int? roleId;
  final int? perPage;

  final bool clearClinicId;
  final bool clearDepartmentId;
  final bool clearDesignationId;
  final bool clearShiftId;
  final bool clearRoleId;

  /// Reset all filters (keeps current search).
  final bool resetAll;

  @override
  List<Object?> get props => [
        status,
        clinicId,
        departmentId,
        designationId,
        shiftId,
        roleId,
        perPage,
        clearClinicId,
        clearDepartmentId,
        clearDesignationId,
        clearShiftId,
        clearRoleId,
        resetAll,
      ];
}
