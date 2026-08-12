import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';

/// ============================================================
/// ERROR MAPPER
/// ------------------------------------------------------------
/// Converts Exceptions → Failures and logs them for debugging.
/// ============================================================

class ErrorMapper {
  ErrorMapper._();

  /// Map a known AppException to the matching Failure.
  static Failure toFailure(AppException exception) {
    AppErrorLogger.logException(exception, where: 'ErrorMapper.toFailure');

    final detail = exception.debugMessage;
    Failure failure;

    if (exception is NetworkException) {
      failure = NetworkFailure(exception.message, detail);
    } else if (exception is RequestTimeoutException) {
      failure = TimeoutFailure(exception.message, detail);
    } else if (exception is UnauthorizedException) {
      failure = UnauthorizedFailure(exception.message, detail);
    } else if (exception is BadRequestException) {
      failure = BadRequestFailure(exception.message, detail);
    } else if (exception is ForbiddenException) {
      failure = ForbiddenFailure(exception.message, detail);
    } else if (exception is NotFoundException) {
      failure = NotFoundFailure(exception.message, detail);
    } else if (exception is CacheException) {
      failure = CacheFailure(exception.message, detail);
    } else if (exception is ServerException) {
      final status = exception.statusCode;
      failure = ServerFailure(
        exception.message,
        detail ?? (status != null ? 'HTTP $status' : null),
      );
    } else {
      failure = UnknownFailure(exception.message, detail);
    }

    return failure;
  }

  /// Map any unknown error (including DioException) to a Failure.
  static Failure fromUnknown(Object error) {
    if (error is DioException && error.error is AppException) {
      return toFailure(error.error as AppException);
    }

    if (error is AppException) {
      return toFailure(error);
    }

    AppErrorLogger.logUnknown(error, where: 'ErrorMapper.fromUnknown');
    return UnknownFailure(error.toString(), error.runtimeType.toString());
  }
}
