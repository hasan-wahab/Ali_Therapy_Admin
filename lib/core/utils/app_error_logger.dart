import 'package:flutter/foundation.dart';

import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/errors/failures.dart';

// ============================================================
// APP ERROR LOGGER
// ------------------------------------------------------------
// Prints a clear block in the debug console so beginners
// can see WHAT went wrong (title + message + detail).
//
//   AppErrorLogger.logFailure(failure);
//   AppErrorLogger.logException(exception);
// ============================================================

class AppErrorLogger {
  AppErrorLogger._();

  static void logFailure(Failure failure, {String? where}) {
    _printBlock(
      source: where ?? 'Failure',
      title: failure.title,
      message: failure.message,
      detail: failure.debugDetail,
      typeName: failure.runtimeType.toString(),
    );
  }

  static void logException(AppException exception, {String? where}) {
    _printBlock(
      source: where ?? 'Exception',
      title: _titleForException(exception),
      message: exception.message,
      detail: exception.debugMessage,
      typeName: exception.runtimeType.toString(),
    );
  }

  static void logUnknown(Object error, {String? where}) {
    _printBlock(
      source: where ?? 'Unknown',
      title: 'Unexpected Error',
      message: error.toString(),
      detail: null,
      typeName: error.runtimeType.toString(),
    );
  }

  /// Log any title + message (e.g. from UI snackbar string path).
  static void log({
    required String title,
    required String message,
    String? detail,
    String? where,
  }) {
    _printBlock(
      source: where ?? 'App',
      title: title,
      message: message,
      detail: detail,
      typeName: 'Manual',
    );
  }

  static String _titleForException(AppException exception) {
    if (exception is NetworkException) return 'No Internet';
    if (exception is RequestTimeoutException) return 'Timeout';
    if (exception is UnauthorizedException) return 'Unauthorized';
    if (exception is BadRequestException) return 'Invalid Request';
    if (exception is ForbiddenException) return 'Access Denied';
    if (exception is NotFoundException) return 'Not Found';
    if (exception is CacheException) return 'Storage Error';
    if (exception is ServerException) return 'Server Error';
    return 'Unexpected Error';
  }

  static void _printBlock({
    required String source,
    required String title,
    required String message,
    required String? detail,
    required String typeName,
  }) {
    debugPrint('');
    debugPrint('╔══════════════════════════════════════════════');
    debugPrint('║ ❌ APP ERROR ($source)');
    debugPrint('╠══════════════════════════════════════════════');
    debugPrint('║ TITLE   : $title');
    debugPrint('║ TYPE    : $typeName');
    debugPrint('║ MESSAGE : $message');
    if (detail != null && detail.trim().isNotEmpty) {
      debugPrint('║ DETAIL  : $detail');
    }
    debugPrint('╚══════════════════════════════════════════════');
    debugPrint('');
  }
}
