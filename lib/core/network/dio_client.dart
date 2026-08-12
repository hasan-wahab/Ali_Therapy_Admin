import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/api_interceptor.dart';

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

  /// Optional: pass a function that returns the auth token.
  DioClient({Future<String?> Function()? getToken}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          Headers.contentTypeHeader: ApiConstants.contentType,
          Headers.acceptHeader: ApiConstants.accept,
        },
      ),
    );

    // 1) Our custom interceptor (token + error mapping)
    _dio.interceptors.add(ApiInterceptor(getToken: getToken));

    // 2) Pretty logger (only in debug mode)
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
}
