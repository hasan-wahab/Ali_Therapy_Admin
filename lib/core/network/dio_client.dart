import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/api_interceptor.dart';
import 'package:ali_therapy_admin/core/network/network_retry_interceptor.dart';
import 'package:ali_therapy_admin/core/services/connectivity_service.dart';

/// ============================================================
/// DIO CLIENT
/// ------------------------------------------------------------
/// This class creates and configures ONE Dio instance
/// for the whole app (base URL, timeouts, interceptors).
///
/// How to use later in a repository / data source:
///   final response = await dioClient.get('admin/users');
/// ============================================================

class DioClient {
  late final Dio _dio;
  final Future<String?> Function()? _getToken;

  /// Optional: pass a function that returns the auth token.
  /// [connectivityService] enables wait + controlled retry for all APIs.
  DioClient({
    Future<String?> Function()? getToken,
    ConnectivityService? connectivityService,
  }) : _getToken = getToken {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        // Web: sendTimeout is only valid when the request has a body.
        // Setting it globally logs a Dio warning on GET/DELETE.
        sendTimeout: kIsWeb ? null : ApiConstants.sendTimeout,
        headers: {
          Headers.contentTypeHeader: ApiConstants.contentType,
          Headers.acceptHeader: ApiConstants.accept,
        },
      ),
    );

    // 1) Map Dio errors → AppException (runs after retry on error path).
    _dio.interceptors.add(ApiInterceptor(getToken: getToken));

    // 2) Wait for connectivity + retry transient network errors (all APIs).
    // Registered after ApiInterceptor so onError runs here FIRST (LIFO).
    if (connectivityService != null) {
      _dio.interceptors.add(
        NetworkRetryInterceptor(
          dio: _dio,
          connectivityService: connectivityService,
        ),
      );
    }

    // 3) Pretty logger (only in debug mode)
    final logger = createDebugLogger();
    if (logger != null) {
      _dio.interceptors.add(logger);
    }
  }

  /// Expose Dio if you need advanced options.
  Dio get dio => _dio;

  // ----------------------------------------------------------
  // SHORT HELPERS
  // Beginners can call these instead of remembering Dio APIs.
  // ----------------------------------------------------------

  /// GET request → read data from server.
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  /// POST request → send new data to server.
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PUT request → update existing data on server.
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// PATCH request → update part of the data.
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// DELETE request → remove data from server.
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Download a file as bytes (profile photo, document image).
  ///
  /// Uses a separate Dio so a 403 from /storage/ does not log as an API error.
  /// Server currently blocks /storage/ even with a valid API token.
  Future<Uint8List?> getFileBytes(String url) async {
    final trimmed = ApiConstants.resolveFileUrl(url);
    if (trimmed.isEmpty) return null;

    final token = await (_getToken?.call() ?? Future<String?>.value());
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: ApiConstants.connectTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
          followRedirects: true,
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );
      final headers = <String, String>{
        Headers.acceptHeader: '*/*',
      };
      if (token != null && token.isNotEmpty) {
        headers[ApiConstants.authorizationHeader] = 'Bearer $token';
      }

      final response = await dio.get<List<int>>(
        trimmed,
        options: Options(
          headers: headers,
          responseType: ResponseType.bytes,
        ),
      );
      final data = response.data;
      if (data == null || data.isEmpty) return null;
      return Uint8List.fromList(data);
    } catch (_) {
      return null;
    }
  }
}
