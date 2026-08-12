import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

// ============================================================
// PROFILE BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
// Register in DI only after repository + use case are ready.
// ============================================================

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<ProfileStarted>(_onStarted);
  }

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    // TODO: call GetProfileUseCase when API is ready.
    emit(const ProfileInitial());
  }
}
