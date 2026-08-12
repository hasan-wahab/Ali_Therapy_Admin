import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'clinical_history_event.dart';
part 'clinical_history_state.dart';

// ============================================================
// CLINICALHISTORY BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ClinicalHistoryBloc extends Bloc<ClinicalHistoryEvent, ClinicalHistoryState> {
  ClinicalHistoryBloc() : super(const ClinicalHistoryInitial()) {
    on<ClinicalHistoryStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ClinicalHistoryStarted event,
    Emitter<ClinicalHistoryState> emit,
  ) async {
    // TODO: call GetClinicalHistoryUseCase when API is ready.
    emit(const ClinicalHistoryInitial());
  }
}
