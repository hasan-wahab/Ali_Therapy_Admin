import 'package:equatable/equatable.dart';

// ============================================================
// FAILURES
// ------------------------------------------------------------
// Failures = safe error objects for BLoC / UI.
//
// Every failure has:
//   title        → short label shown in snackbar (e.g. "Server Error")
//   message      → user-friendly detail
//   debugDetail  → extra info for console logs (optional)
// ============================================================

/// Base class for all failures.
abstract class Failure extends Equatable {
  /// Short title for UI (snackbar header).
  final String title;

  /// User-friendly message for the UI.
  final String message;

  /// Extra detail for developers (printed in console).
  final String? debugDetail;

  const Failure({
    required this.title,
    required this.message,
    this.debugDetail,
  });

  @override
  List<Object?> get props => [title, message, debugDetail];
}

/// Server / API failed.
class ServerFailure extends Failure {
  const ServerFailure([
    String message = 'Server error. Please try again later.',
    String? debugDetail,
  ]) : super(
          title: 'Server Error',
          message: message,
          debugDetail: debugDetail,
        );
}

/// Device has no internet.
class NetworkFailure extends Failure {
  const NetworkFailure([
    String message = 'No internet connection.',
    String? debugDetail,
  ]) : super(
          title: 'No Internet',
          message: message,
          debugDetail: debugDetail,
        );
}

/// Local / cached data failed.
class CacheFailure extends Failure {
  const CacheFailure([
    String message = 'Failed to access local data.',
    String? debugDetail,
  ]) : super(
          title: 'Storage Error',
          message: message,
          debugDetail: debugDetail,
        );
}

/// User is not logged in / token expired.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([
    String message = 'Session expired. Please login again.',
    String? debugDetail,
  ]) : super(
          title: 'Unauthorized',
          message: message,
          debugDetail: debugDetail,
        );
}

/// Wrong input from the client (form / body).
class BadRequestFailure extends Failure {
  const BadRequestFailure([
    String message = 'Invalid request data.',
    String? debugDetail,
  ]) : super(
          title: 'Invalid Request',
          message: message,
          debugDetail: debugDetail,
        );
}

/// User is not allowed to do this action.
class ForbiddenFailure extends Failure {
  const ForbiddenFailure([
    String message = 'Access denied.',
    String? debugDetail,
  ]) : super(
          title: 'Access Denied',
          message: message,
          debugDetail: debugDetail,
        );
}

/// Requested item does not exist.
class NotFoundFailure extends Failure {
  const NotFoundFailure([
    String message = 'Data not found.',
    String? debugDetail,
  ]) : super(
          title: 'Not Found',
          message: message,
          debugDetail: debugDetail,
        );
}

/// API call took too long / unstable connection after retries.
class TimeoutFailure extends Failure {
  const TimeoutFailure([
    String message =
        'Connection is unstable. Please check your internet and try again.',
    String? debugDetail,
  ]) : super(
          title: 'Connection Issue',
          message: message,
          debugDetail: debugDetail,
        );
}

/// Any other unexpected error.
class UnknownFailure extends Failure {
  const UnknownFailure([
    String message = 'Something went wrong.',
    String? debugDetail,
  ]) : super(
          title: 'Unexpected Error',
          message: message,
          debugDetail: debugDetail,
        );
}
