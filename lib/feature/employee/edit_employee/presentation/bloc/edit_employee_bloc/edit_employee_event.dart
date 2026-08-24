part of 'edit_employee_bloc.dart';

abstract class EditEmployeeEvent extends Equatable {
  const EditEmployeeEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened — load GET employees/{id}/edit
class EditEmployeeStarted extends EditEmployeeEvent {
  const EditEmployeeStarted({required this.employeeId});

  final String employeeId;

  @override
  List<Object?> get props => [employeeId];
}

/// Last-step Submit — POST /employees/update/{id}
class EditEmployeeSubmitted extends EditEmployeeEvent {
  const EditEmployeeSubmitted({
    required this.form,
  });

  final EditEmployeeFormEntity form;

  @override
  List<Object?> get props => [form];
}
