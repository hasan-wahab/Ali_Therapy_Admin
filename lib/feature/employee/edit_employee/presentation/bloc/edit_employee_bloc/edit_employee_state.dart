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

class EditEmployeeLoaded extends EditEmployeeState {
  const EditEmployeeLoaded({
    required this.page,
    this.isSaving = false,
    this.successMessage,
  });

  final EditEmployeeEntity page;
  final bool isSaving;
  final String? successMessage;

  EditEmployeeLoaded copyWith({
    EditEmployeeEntity? page,
    bool? isSaving,
    Object? successMessage = _keep,
  }) {
    return EditEmployeeLoaded(
      page: page ?? this.page,
      isSaving: isSaving ?? this.isSaving,
      successMessage: successMessage == _keep
          ? this.successMessage
          : successMessage as String?,
    );
  }

  @override
  List<Object?> get props => [page, isSaving, successMessage];
}

class EditEmployeeError extends EditEmployeeState {
  const EditEmployeeError({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];
}

const Object _keep = Object();
