import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/edit_employee_domain/entities/edit_employee_entity.dart';
import '../../../domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import '../../../domain/edit_employee_domain/usecases/get_edit_employee_usecase.dart';
import '../../../domain/edit_employee_domain/usecases/update_employee_usecase.dart';

part 'edit_employee_event.dart';
part 'edit_employee_state.dart';

// ============================================================
// EDIT EMPLOYEE BLOC
// ------------------------------------------------------------
// Started   → GET employees/{id} (same as View)
// Submitted → POST employees/update/{id}
// ============================================================

class EditEmployeeBloc extends Bloc<EditEmployeeEvent, EditEmployeeState> {
  EditEmployeeBloc({
    required this.getEditEmployeeUseCase,
    required this.updateEmployeeUseCase,
  }) : super(const EditEmployeeInitial()) {
    on<EditEmployeeStarted>(_onStarted);
    on<EditEmployeeSubmitted>(_onSubmitted);
  }

  final GetEditEmployeeUseCase getEditEmployeeUseCase;
  final UpdateEmployeeUseCase updateEmployeeUseCase;

  Future<void> _onStarted(
    EditEmployeeStarted event,
    Emitter<EditEmployeeState> emit,
  ) async {
    final employeeId = event.employeeId.trim();
    if (employeeId.isEmpty || employeeId == '_') {
      emit(
        const EditEmployeeError(
          title: 'Missing Id',
          message: 'Employee id is missing. Open Edit from All Employees again.',
        ),
      );
      return;
    }

    emit(const EditEmployeeLoading());

    final result = await getEditEmployeeUseCase(
      GetEditEmployeeParams(employeeId: employeeId),
    );

    result.when(
      success: (page) => emit(EditEmployeeLoaded(page: page)),
      failure: (failure) => emit(
        EditEmployeeError(
          title: failure.title,
          message: failure.message,
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    EditEmployeeSubmitted event,
    Emitter<EditEmployeeState> emit,
  ) async {
    final current = state;
    if (current is! EditEmployeeLoaded) return;
    if (current.isSaving) return;

    emit(current.copyWith(isSaving: true, successMessage: null));

    final result = await updateEmployeeUseCase(
      UpdateEmployeeParams(
        employeeId: current.page.form.id.isNotEmpty
            ? current.page.form.id
            : event.form.id,
        form: event.form,
        options: current.page.options,
      ),
    );

    result.when(
      success: (data) {
        emit(
          current.copyWith(
            isSaving: false,
            successMessage: data.message,
          ),
        );
      },
      failure: (failure) {
        emit(
          EditEmployeeError(
            title: failure.title,
            message: failure.message,
          ),
        );
        emit(current.copyWith(isSaving: false, successMessage: null));
      },
    );
  }
}
