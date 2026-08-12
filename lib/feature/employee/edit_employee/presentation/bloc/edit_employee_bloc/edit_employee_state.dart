part of 'edit_employee_bloc.dart';

abstract class EditEmployeeState extends Equatable {
  const EditEmployeeState();

  @override
  List<Object?> get props => [];
}

class EditEmployeeInitial extends EditEmployeeState {
  const EditEmployeeInitial();
}

class EditEmployeeLoading extends EditEmployeeState {
  const EditEmployeeLoading();
}

class EditEmployeeError extends EditEmployeeState {
  final String message;

  const EditEmployeeError(this.message);

  @override
  List<Object?> get props => [message];
}
