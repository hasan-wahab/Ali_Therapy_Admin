part of 'edit_employee_bloc.dart';

abstract class EditEmployeeEvent extends Equatable {
  const EditEmployeeEvent();

  @override
  List<Object?> get props => [];
}

/// Page opened / first load.
class EditEmployeeStarted extends EditEmployeeEvent {
  const EditEmployeeStarted();
}
