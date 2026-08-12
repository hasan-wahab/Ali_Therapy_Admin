import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_experience_event.dart';
part 'add_experience_state.dart';

// ============================================================
// ADDEXPERIENCE BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class AddExperienceBloc extends Bloc<AddExperienceEvent, AddExperienceState> {
  AddExperienceBloc() : super(const AddExperienceInitial()) {
    on<AddExperienceStarted>(_onStarted);
  }

  Future<void> _onStarted(
    AddExperienceStarted event,
    Emitter<AddExperienceState> emit,
  ) async {
    // TODO: call GetAddExperienceUseCase when API is ready.
    emit(const AddExperienceInitial());
  }
}
