import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employee_model.dart';

// ============================================================
// ALLEMPLOYEES REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// GET .../api/admin/employees-list
// Accepts either a raw JSON array OR { success, data: [...] }.
// ============================================================

class AllEmployeesRemoteDataSourceImpl implements AllEmployeesRemoteDataSource {
  AllEmployeesRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<List<EmployeeModel>> getAllEmployees() async {
    try {
      // Bearer token is attached automatically by ApiInterceptor.
      final response = await dioClient.get(ApiConstants.employeesList);

      final list = _extractEmployeeList(response.data);
      return EmployeeModel.listFromJson(list);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load employees. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read employees response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading employees.',
        debugMessage: e.toString(),
      );
    }
  }

  /// Supports:
  /// - [ {...}, {...} ]
  /// - { success, data: [ {...}, {...} ] }
  /// - { data: [ {...}, {...} ] }
  List<dynamic> _extractEmployeeList(dynamic raw) {
    if (raw is List) return raw;

    final body = _asStringKeyMap(raw);
    if (body == null) {
      throw const ServerException(
        message: 'Unexpected employees response format.',
      );
    }

    if (body['success'] == false) {
      final message = body['message']?.toString();
      throw BadRequestException(
        message: (message != null && message.isNotEmpty)
            ? message
            : 'Could not load employees. Please try again.',
      );
    }

    final data = body['data'];
    if (data is List) return data;

    // Some APIs put the list at the root under another key.
    if (body['employees'] is List) {
      return body['employees'] as List;
    }

    throw const ServerException(
      message: 'Employees list is missing in the response.',
    );
  }

  Map<String, dynamic>? _asStringKeyMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return null;
  }
}
