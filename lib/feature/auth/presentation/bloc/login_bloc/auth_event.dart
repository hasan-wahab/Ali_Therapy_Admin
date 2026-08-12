part of 'auth_bloc.dart';

// ============================================================
// AUTH EVENTS
// ------------------------------------------------------------
// Events = actions from the UI.
// ============================================================

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// User pressed the Login button.
class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// User pressed Logout.
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

/// App opened on login screen — check saved token.
class AuthSessionCheckRequested extends AuthEvent {
  const AuthSessionCheckRequested();
}

/// Reset auth state back to initial.
class AuthResetRequested extends AuthEvent {
  const AuthResetRequested();
}
