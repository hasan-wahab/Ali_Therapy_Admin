part of 'auth_bloc.dart';

// ============================================================
// AUTH STATES
// ------------------------------------------------------------
// States = what the UI should show right now.
// ============================================================

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// First / idle state.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// API call is running — show a loader.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Login (or restored session) succeeded.
class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.login);

  /// Full login payload: token + user + permissions + roles.
  final LoginEntity login;

  @override
  List<Object?> get props => [login];
}

/// User is logged out / must login.
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Something went wrong — show title + message.
class AuthError extends AuthState {
  const AuthError({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  List<Object?> get props => [title, message];
}
