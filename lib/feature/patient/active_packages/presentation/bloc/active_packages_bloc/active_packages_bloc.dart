import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'active_packages_event.dart';
part 'active_packages_state.dart';

// ============================================================
// ACTIVEPACKAGES BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ActivePackagesBloc extends Bloc<ActivePackagesEvent, ActivePackagesState> {
  ActivePackagesBloc() : super(const ActivePackagesInitial()) {
    on<ActivePackagesStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ActivePackagesStarted event,
    Emitter<ActivePackagesState> emit,
  ) async {
    // TODO: call GetActivePackagesUseCase when API is ready.
    emit(const ActivePackagesInitial());
  }
}
