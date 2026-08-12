import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/auth/auth_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/auth/data/change_password_data/models/change_password_model.dart';
import 'package:ali_therapy_admin/feature/auth/data/forget_password_data/models/forget_password_model.dart';
import 'package:ali_therapy_admin/feature/auth/data/login_data/models/login_model.dart';

// ============================================================
// AUTH REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// ONLY place that calls auth HTTP APIs (login / logout / forget-password).
// ============================================================

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.login,
        data: {'email': email.trim(), 'password': password},
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected login response format.',
        );
      }

      // API shape: { success, status_code, message, data: { ... } }
      final success = body['success'];
      if (success == false) {
        final message = body['message']?.toString();
        throw UnauthorizedException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Login failed. Please check your email and password.',
        );
      }

      final login = LoginModel.fromJson(body);

      // Token must be real — never accept "_" / empty.
      if (login.accessToken.isEmpty || login.accessToken == '_') {
        throw const ServerException(
          message: 'Login succeeded but access token is missing.',
        );
      }

      return login;
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Login request failed. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read login response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong during login.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dioClient.post(ApiConstants.logout);
    } on DioException catch (e) {
      if (e.error is AppException) return;
    } catch (_) {
      // Ignore — clearing local token is enough for the user.
    }
  }

  @override
  Future<ForgetPasswordModel> forgetPassword({required String email}) async {
    try {
      final response = await dioClient.post(
        ApiConstants.forgetPassword,
        data: {'email': email.trim()},
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected forget-password response format.',
        );
      }

      // Same envelope as login: { success, status_code, message, data? }
      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not send reset link. Please check your email.',
        );
      }

      return ForgetPasswordModel.fromJson(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Forget password request failed. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read forget-password response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong during forget password.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<ChangePasswordModel> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Bearer token is attached automatically by ApiInterceptor.
      final response = await dioClient.post(
        ApiConstants.changePassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected change-password response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not change password. Please try again.',
        );
      }

      return ChangePasswordModel.fromJson(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Change password request failed. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read change-password response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong during change password.',
        debugMessage: e.toString(),
      );
    }
  }

  /// Dio sometimes returns Map with dynamic keys — normalize to String keys.
  Map<String, dynamic>? _asStringKeyMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    return null;
  }
}
