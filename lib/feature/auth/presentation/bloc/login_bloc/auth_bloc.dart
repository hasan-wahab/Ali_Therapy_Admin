import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/usecase/usecase.dart';

import '../../../domain/login_domain/entities/login_entity.dart';
import '../../../domain/login_domain/usecases/login_usecase.dart';
import '../../../domain/login_domain/usecases/logout_usecase.dart';
import '../../../domain/login_domain/usecases/restore_session_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// ============================================================
// AUTH BLOC
// ------------------------------------------------------------
// Connects UI events → use cases → new UI states.
//
// Login flow:
//   AuthLoginRequested → LoginUseCase → AuthAuthenticated / AuthError
//
// Session flow:
//   AuthSessionCheckRequested → RestoreSessionUseCase → AuthAuthenticated?
// ============================================================

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.restoreSessionUseCase,
  }) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthSessionCheckRequested>(_onSessionCheckRequested);
    on<AuthResetRequested>(_onResetRequested);
  }

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RestoreSessionUseCase restoreSessionUseCase;

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.when(
      success: (login) => emit(AuthAuthenticated(login)),
      failure: (failure) => emit(
        AuthError(title: failure.title, message: failure.message),
      ),
    );
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await logoutUseCase(const NoParams());

    result.when(
      success: (_) => emit(const AuthUnauthenticated()),
      failure: (failure) => emit(
        AuthError(title: failure.title, message: failure.message),
      ),
    );
  }

  Future<void> _onSessionCheckRequested(
    AuthSessionCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await restoreSessionUseCase(const NoParams());

    result.when(
      success: (login) {
        if (login != null) {
          emit(AuthAuthenticated(login));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
      failure: (_) => emit(const AuthUnauthenticated()),
    );
  }

  void _onResetRequested(AuthResetRequested event, Emitter<AuthState> emit) {
    emit(const AuthInitial());
  }
}
