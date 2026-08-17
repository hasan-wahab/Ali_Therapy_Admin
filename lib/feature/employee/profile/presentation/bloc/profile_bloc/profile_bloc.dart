import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/profile_domain/entities/profile_entity.dart';
import '../../../domain/profile_domain/usecases/get_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

// ============================================================
// PROFILE BLOC
// ------------------------------------------------------------
// Started(employeeId) → GET employees/{id} once (from View action).
// Section screens do NOT call this again — they reuse ProfileEntity.
// ============================================================

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.getProfileUseCase})
    : super(const ProfileInitial()) {
    on<ProfileStarted>(_onStarted);
  }

  final GetProfileUseCase getProfileUseCase;

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    final employeeId = event.employeeId.trim();
    if (employeeId.isEmpty || employeeId == '_') {
      emit(
        const ProfileError(
          title: 'Missing Id',
          message: 'Employee id is missing. Open profile from View again.',
        ),
      );
      return;
    }

    emit(const ProfileLoading());

    final result = await getProfileUseCase(
      GetProfileParams(employeeId: employeeId),
    );

    result.when(
      success: (profile) => emit(ProfileLoaded(profile)),
      failure: (failure) => emit(
        ProfileError(
          title: failure.title,
          message: failure.message,
        ),
      ),
    );
  }
}
