import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_education_event.dart';
part 'add_education_state.dart';

// ============================================================
// ADDEDUCATION BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class AddEducationBloc extends Bloc<AddEducationEvent, AddEducationState> {
  AddEducationBloc() : super(const AddEducationInitial()) {
    on<AddEducationStarted>(_onStarted);
  }

  Future<void> _onStarted(
    AddEducationStarted event,
    Emitter<AddEducationState> emit,
  ) async {
    // TODO: call GetAddEducationUseCase when API is ready.
    emit(const AddEducationInitial());
  }
}
