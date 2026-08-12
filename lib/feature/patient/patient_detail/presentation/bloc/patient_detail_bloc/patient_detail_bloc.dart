import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_detail_event.dart';
part 'patient_detail_state.dart';

// ============================================================
// PATIENTDETAIL BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class PatientDetailBloc extends Bloc<PatientDetailEvent, PatientDetailState> {
  PatientDetailBloc() : super(const PatientDetailInitial()) {
    on<PatientDetailStarted>(_onStarted);
  }

  Future<void> _onStarted(
    PatientDetailStarted event,
    Emitter<PatientDetailState> emit,
  ) async {
    // TODO: call GetPatientDetailUseCase when API is ready.
    emit(const PatientDetailInitial());
  }
}
