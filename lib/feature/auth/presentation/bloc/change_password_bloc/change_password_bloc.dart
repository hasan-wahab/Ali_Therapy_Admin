import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/change_password_domain/usecases/change_password_usecase.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

// ============================================================
// CHANGE PASSWORD BLOC
// ------------------------------------------------------------
// UI → ChangePasswordSubmitted → UseCase → Success / Error
// ============================================================

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({required this.changePasswordUseCase})
      : super(const ChangePasswordInitial()) {
    on<ChangePasswordSubmitted>(_onSubmitted);
  }

  final ChangePasswordUseCase changePasswordUseCase;

  Future<void> _onSubmitted(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(const ChangePasswordLoading());

    final result = await changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ),
    );

    result.when(
      success: (entity) {
        final message = entity.message.trim();
        emit(
          ChangePasswordSuccess(
            (message.isEmpty || message == '_')
                ? 'Password changed successfully.'
                : message,
          ),
        );
      },
      failure: (failure) => emit(
        ChangePasswordError(title: failure.title, message: failure.message),
      ),
    );
  }
}
