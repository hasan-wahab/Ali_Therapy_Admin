import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employees_page_model.dart';

// ============================================================
// ALLEMPLOYEES REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// GET .../api/admin/employees-list?page=N
// Supports Laravel paginate + older list shapes.
// ============================================================

class AllEmployeesRemoteDataSourceImpl implements AllEmployeesRemoteDataSource {
  AllEmployeesRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<EmployeesPageModel> getEmployeesPage({required int page}) async {
    try {
      final response = await dioClient.get(
        ApiConstants.employeesList,
        queryParameters: {'page': page},
      );

      return _parsePage(response.data, requestedPage: page);
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

  EmployeesPageModel _parsePage(dynamic raw, {required int requestedPage}) {
    // Raw array → treat as single page.
    if (raw is List) {
      return EmployeesPageModel.fromList(EmployeeModel.listFromJson(raw));
    }

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

    // { success, data: { current_page, data: [...] } }
    final data = body['data'];
    final dataMap = _asStringKeyMap(data);
    if (dataMap != null && dataMap['data'] is List) {
      return EmployeesPageModel.fromJson(dataMap);
    }

    // Laravel paginate at root: { current_page, data: [...] }
    if (body['data'] is List && body.containsKey('current_page')) {
      return EmployeesPageModel.fromJson(body);
    }

    // { data: [ ... ] } without page meta
    if (data is List) {
      return EmployeesPageModel.fromList(EmployeeModel.listFromJson(data));
    }

    if (body['employees'] is List) {
      return EmployeesPageModel.fromList(
        EmployeeModel.listFromJson(body['employees']),
      );
    }

    throw ServerException(
      message: 'Employees list is missing in the response.',
      debugMessage: 'page=$requestedPage',
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
