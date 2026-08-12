import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_profile_event.dart';
part 'patient_profile_state.dart';

// ============================================================
// PATIENTPROFILE BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class PatientProfileBloc extends Bloc<PatientProfileEvent, PatientProfileState> {
  PatientProfileBloc() : super(const PatientProfileInitial()) {
    on<PatientProfileStarted>(_onStarted);
  }

  Future<void> _onStarted(
    PatientProfileStarted event,
    Emitter<PatientProfileState> emit,
  ) async {
    // TODO: call GetPatientProfileUseCase when API is ready.
    emit(const PatientProfileInitial());
  }
}
