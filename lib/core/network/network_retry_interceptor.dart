import 'dart:async';

import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/services/connectivity_service.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';

/// ============================================================
/// NETWORK RETRY INTERCEPTOR (all APIs)
/// ------------------------------------------------------------
/// On transient network problems:
///   1) Wait for network interface restore (if offline)
///   2) Retry the same request (max 3 attempts total)
///
/// Does NOT retry:
///   - 4xx (401 wrong password, 400, 403, 404…)
///   - cancelled requests
///   - normal 5xx except 502 / 503 / 504
///
/// Credentials stay in RequestOptions only — never saved here.
/// ============================================================

class NetworkRetryInterceptor extends Interceptor {
  NetworkRetryInterceptor({
    required this.dio,
    required this.connectivityService,
    this.maxAttempts = 3,
    this.retryDelay = const Duration(seconds: 2),
    this.connectivityWaitTimeout = const Duration(seconds: 12),
  });

  final Dio dio;
  final ConnectivityService connectivityService;

  /// First try + retries. Example: 3 → 1 original + 2 retries.
  final int maxAttempts;
  final Duration retryDelay;
  final Duration connectivityWaitTimeout;

  static const String _attemptKey = 'network_retry_attempt';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Before first send: if interface is down, wait briefly for restore.
    final attempt = options.extra[_attemptKey] as int? ?? 0;
    if (attempt == 0 && !await connectivityService.hasConnection) {
      final restored = await connectivityService.waitForConnection(
        timeout: connectivityWaitTimeout,
      );
      if (!restored) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            message: 'No internet connection.',
          ),
        );
      }
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_isTransient(err)) {
      return handler.next(err);
    }

    final attempt = err.requestOptions.extra[_attemptKey] as int? ?? 0;
    if (attempt + 1 >= maxAttempts) {
      AppErrorLogger.log(
        title: 'Network Retry',
        message: 'Max attempts reached (${attempt + 1}/$maxAttempts)',
        detail: '${err.requestOptions.method} ${err.requestOptions.path}',
        where: 'NetworkRetryInterceptor',
      );
      return handler.next(err);
    }

    // Offline → wait for interface. Online but timeout → short delay.
    final online = await connectivityService.hasConnection;
    if (!online) {
      final restored = await connectivityService.waitForConnection(
        timeout: connectivityWaitTimeout,
      );
      if (!restored) {
        return handler.next(err);
      }
    } else {
      await Future<void>.delayed(retryDelay);
    }

    final nextAttempt = attempt + 1;
    final options = err.requestOptions;
    options.extra[_attemptKey] = nextAttempt;

    AppErrorLogger.log(
      title: 'Network Retry',
      message: 'Retrying request (attempt ${nextAttempt + 1}/$maxAttempts)',
      detail: '${options.method} ${options.path}',
      where: 'NetworkRetryInterceptor',
    );

    try {
      final response = await dio.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      // Same path again — attempt count lives in request extra.
      return onError(retryError, handler);
    }
  }

  /// Transient = worth retrying after network recovery.
  bool _isTransient(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;

      case DioExceptionType.badResponse:
        final code = err.response?.statusCode;
        // Gateway / temporary upstream issues only.
        return code == 502 || code == 503 || code == 504;

      case DioExceptionType.unknown:
        return _looksLikeSocketIssue(err);

      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.transformTimeout:
        return false;
    }
  }

  /// Avoid dart:io (breaks Flutter web). Use type name + message.
  bool _looksLikeSocketIssue(DioException err) {
    final nested = err.error;
    if (nested is TimeoutException) return true;

    final typeName = nested?.runtimeType.toString() ?? '';
    if (typeName.contains('SocketException')) return true;

    final message = (err.message ?? nested?.toString() ?? '').toLowerCase();
    return message.contains('socket') ||
        message.contains('network') ||
        message.contains('connection') ||
        message.contains('timed out') ||
        message.contains('timeout');
  }
}
