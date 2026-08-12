import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_employee_event.dart';
part 'edit_employee_state.dart';

// ============================================================
// EDITEMPLOYEE BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class EditEmployeeBloc extends Bloc<EditEmployeeEvent, EditEmployeeState> {
  EditEmployeeBloc() : super(const EditEmployeeInitial()) {
    on<EditEmployeeStarted>(_onStarted);
  }

  Future<void> _onStarted(
    EditEmployeeStarted event,
    Emitter<EditEmployeeState> emit,
  ) async {
    // TODO: call GetEditEmployeeUseCase when API is ready.
    emit(const EditEmployeeInitial());
  }
}
