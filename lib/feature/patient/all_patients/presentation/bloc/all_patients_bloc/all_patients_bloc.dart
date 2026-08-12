import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_patients_event.dart';
part 'all_patients_state.dart';

// ============================================================
// ALLPATIENTS BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class AllPatientsBloc extends Bloc<AllPatientsEvent, AllPatientsState> {
  AllPatientsBloc() : super(const AllPatientsInitial()) {
    on<AllPatientsStarted>(_onStarted);
  }

  Future<void> _onStarted(
    AllPatientsStarted event,
    Emitter<AllPatientsState> emit,
  ) async {
    // TODO: call GetAllPatientsUseCase when API is ready.
    emit(const AllPatientsInitial());
  }
}
