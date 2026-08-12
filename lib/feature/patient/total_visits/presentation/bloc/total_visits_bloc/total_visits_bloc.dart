import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'total_visits_event.dart';
part 'total_visits_state.dart';

// ============================================================
// TOTALVISITS BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class TotalVisitsBloc extends Bloc<TotalVisitsEvent, TotalVisitsState> {
  TotalVisitsBloc() : super(const TotalVisitsInitial()) {
    on<TotalVisitsStarted>(_onStarted);
  }

  Future<void> _onStarted(
    TotalVisitsStarted event,
    Emitter<TotalVisitsState> emit,
  ) async {
    // TODO: call GetTotalVisitsUseCase when API is ready.
    emit(const TotalVisitsInitial());
  }
}
