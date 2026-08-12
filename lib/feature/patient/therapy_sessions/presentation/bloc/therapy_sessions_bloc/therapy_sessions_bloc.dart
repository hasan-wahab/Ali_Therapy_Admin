import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'therapy_sessions_event.dart';
part 'therapy_sessions_state.dart';

// ============================================================
// THERAPYSESSIONS BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class TherapySessionsBloc extends Bloc<TherapySessionsEvent, TherapySessionsState> {
  TherapySessionsBloc() : super(const TherapySessionsInitial()) {
    on<TherapySessionsStarted>(_onStarted);
  }

  Future<void> _onStarted(
    TherapySessionsStarted event,
    Emitter<TherapySessionsState> emit,
  ) async {
    // TODO: call GetTherapySessionsUseCase when API is ready.
    emit(const TherapySessionsInitial());
  }
}
