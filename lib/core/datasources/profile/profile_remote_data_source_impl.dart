import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/profile/profile_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/employee/profile/data/profile_data/models/profile_model.dart';

// ============================================================
// PROFILE REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// GET .../api/admin/employees/{id}
// Accepts full envelope { data: {...} } or plain profile map.
// ============================================================

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<ProfileModel> getProfile({required String employeeId}) async {
    try {
      final response = await dioClient.get(
        ApiConstants.employeeShow(employeeId),
      );

      final map = _unwrapProfileMap(response.data);
      return ProfileModel.fromJson(map);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load profile. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read profile response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading profile.',
        debugMessage: e.toString(),
      );
    }
  }

  /// Prefer `data` object when API wraps the employee.
  Map<String, dynamic> _unwrapProfileMap(dynamic raw) {
    if (raw is! Map) {
      throw const FormatException('Profile response is not a JSON object.');
    }

    final root = Map<String, dynamic>.from(raw);
    final data = root['data'];
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return root;
  }
}
