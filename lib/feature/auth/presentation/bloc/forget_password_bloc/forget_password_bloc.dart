import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/forget_password_domain/usecases/forget_password_usecase.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

// ============================================================
// FORGET PASSWORD BLOC
// ------------------------------------------------------------
// UI → ForgetPasswordSubmitted → UseCase → Success / Error
// ============================================================

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc({required this.forgetPasswordUseCase})
      : super(const ForgetPasswordInitial()) {
    on<ForgetPasswordSubmitted>(_onSubmitted);
  }

  final ForgetPasswordUseCase forgetPasswordUseCase;

  Future<void> _onSubmitted(
    ForgetPasswordSubmitted event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(const ForgetPasswordLoading());

    final result = await forgetPasswordUseCase(
      ForgetPasswordParams(email: event.email),
    );

    result.when(
      success: (entity) {
        final message = entity.message.trim();
        emit(
          ForgetPasswordSuccess(
            (message.isEmpty || message == '_')
                ? 'If this email exists, a reset link will be sent.'
                : message,
          ),
        );
      },
      failure: (failure) => emit(
        ForgetPasswordError(title: failure.title, message: failure.message),
      ),
    );
  }
}
