import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';

/// ============================================================
/// API INTERCEPTOR
/// ------------------------------------------------------------
/// An interceptor sits BETWEEN your app and Dio.
///
/// It can:
///   - Add the auth token to every request
///   - Convert Dio errors into our AppException classes
///   - Log requests / responses in debug mode
/// ============================================================

class ApiInterceptor extends Interceptor {
  /// Optional function that returns the saved login token.
  /// We pass this from outside so this class stays simple.
  final Future<String?> Function()? getToken;

  ApiInterceptor({this.getToken});

  // ----------------------------------------------------------
  // BEFORE the request is sent
  // ----------------------------------------------------------
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add JSON headers on every request.
    options.headers[Headers.contentTypeHeader] = ApiConstants.contentType;
    options.headers[Headers.acceptHeader] = ApiConstants.accept;

    // If we have a token, attach it as: Authorization: Bearer <token>
    if (getToken != null) {
      final token = await getToken!();
      if (token != null && token.isNotEmpty) {
        options.headers[ApiConstants.authorizationHeader] = 'Bearer $token';
      }
    }

    // Continue with the request.
    handler.next(options);
  }

  // ----------------------------------------------------------
  // AFTER we get a successful response
  // ----------------------------------------------------------
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  // ----------------------------------------------------------
  // WHEN something goes wrong
  // ----------------------------------------------------------
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Convert DioException → our own Exception, then reject.
    final exception = _mapDioError(err);
    AppErrorLogger.logException(
      exception,
      where: 'API ${err.requestOptions.method} ${err.requestOptions.path}',
    );
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        response: err.response,
      ),
    );
  }

  /// Maps Dio error types / status codes to our AppException classes.
  AppException _mapDioError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const RequestTimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException(
          debugMessage: 'Connection error from Dio',
        );

      case DioExceptionType.badResponse:
        return _mapStatusCode(err.response?.statusCode, err.response?.data);

      case DioExceptionType.cancel:
        return const UnknownException(
          message: 'Request was cancelled.',
          debugMessage: 'DioExceptionType.cancel',
        );

      default:
        return UnknownException(debugMessage: err.message);
    }
  }

  /// Maps HTTP status codes (401, 404, 500…) to exceptions.
  AppException _mapStatusCode(int? statusCode, dynamic data) {
    // Try to read a message from the API body if it exists.
    final apiMessage = _readApiMessage(data);

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: apiMessage ?? 'Invalid request data.',
        );
      case 401:
        return UnauthorizedException(
          message: apiMessage ?? 'Session expired. Please login again.',
        );
      case 403:
        return ForbiddenException(message: apiMessage ?? 'Access denied.');
      case 404:
        return NotFoundException(message: apiMessage ?? 'Data not found.');
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: apiMessage ?? 'Server error. Please try again later.',
          statusCode: statusCode,
        );
      default:
        return ServerException(
          message: apiMessage ?? 'Unexpected server response.',
          statusCode: statusCode,
          debugMessage: 'HTTP $statusCode',
        );
    }
  }

  /// Tries to pull "message" from JSON body.
  /// Supports: { "message": "..." } or { "error": "..." }
  String? _readApiMessage(dynamic data) {
    if (data is Map) {
      final message = data['message'] ?? data['error'] ?? data['msg'];
      if (message is String && message.isNotEmpty) return message;
    }
    return null;
  }
}

/// Creates a PrettyDioLogger only in DEBUG mode.
/// In release builds we do NOT print API logs (safer).
PrettyDioLogger? createDebugLogger() {
  if (!kDebugMode) return null;

  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
  );
}
