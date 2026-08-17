// ============================================================
// EXCEPTIONS
// ------------------------------------------------------------
// Exceptions = errors that happen while talking to API / DB.
// We THROW these in the DATA layer (remote / local sources).
//
// Later, the Repository CATCHES them and converts them into
// Failure objects (see failures.dart) for the UI / BLoC.
// ============================================================

/// Base class for all app exceptions.
/// Every custom exception below extends this class.
class AppException implements Exception {
  /// Message that can be shown to the user (simple English).
  final String message;

  /// Extra detail for developers (logs / debug console).
  final String? debugMessage;

  const AppException({
    required this.message,
    this.debugMessage,
  });

  @override
  String toString() {
    // Prefer debug message in logs if it exists.
    return debugMessage ?? message;
  }
}

/// Thrown when the API / server returns an error
/// (example: 500 Internal Server Error).
class ServerException extends AppException {
  /// HTTP status code from the server (optional).
  final int? statusCode;

  const ServerException({
    super.message = 'Server error. Please try again later.',
    super.debugMessage,
    this.statusCode,
  });
}

/// Thrown when there is no internet connection.
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection.',
    super.debugMessage,
  });
}

/// Thrown when reading / writing cached / local data fails.
class CacheException extends AppException {
  const CacheException({
    super.message = 'Failed to access local data.',
    super.debugMessage,
  });
}

/// Thrown when email/password (or token) is invalid → HTTP 401.
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Session expired. Please login again.',
    super.debugMessage = '401 Unauthorized',
  });
}

/// Thrown when the request data is wrong → HTTP 400.
class BadRequestException extends AppException {
  const BadRequestException({
    super.message = 'Invalid request data.',
    super.debugMessage = '400 Bad Request',
  });
}

/// Thrown when access is denied → HTTP 403.
class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'Access denied.',
    super.debugMessage = '403 Forbidden',
  });
}

/// Thrown when the API cannot find the data → HTTP 404.
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Data not found.',
    super.debugMessage = '404 Not Found',
  });
}

/// Thrown when the API takes too long to reply.
/// Named RequestTimeoutException so it does not clash with
/// Dart's built-in TimeoutException from dart:async.
class RequestTimeoutException extends AppException {
  const RequestTimeoutException({
    super.message =
        'Connection is unstable. Please check your internet and try again.',
    super.debugMessage = 'Request timeout',
  });
}

/// Thrown for any error we did not expect.
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'Something went wrong.',
    super.debugMessage,
  });
}
