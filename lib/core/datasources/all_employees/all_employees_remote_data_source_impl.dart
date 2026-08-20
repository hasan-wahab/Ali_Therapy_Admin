import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/all_employees/all_employees_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/assign_employee_biometric_id_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/assign_employee_device_id_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/change_employee_password_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employees_filters_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/employees_page_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/terminate_employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/data/all_employees_data/models/toggle_status_model.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_list_query.dart';

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
  Future<EmployeesPageModel> getEmployeesPage({
    required EmployeesListQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.employeesList,
        queryParameters: query.toQueryParameters(),
      );

      return _parsePage(response.data, requestedPage: query.page);
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

  @override
  Future<EmployeesFiltersModel> getEmployeesFilters() async {
    try {
      final response = await dioClient.get(ApiConstants.employeesFiltersData);

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected employees filters response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not load employee filters. Please try again.',
        );
      }

      return EmployeesFiltersModel.fromResponse(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load employee filters. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read employees filters response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading employee filters.',
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

  @override
  Future<ToggleStatusModel> toggleEmployeeStatus({
    required String employeeId,
    required bool newStatus,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.employeeToggleStatus(employeeId),
        data: {'status': newStatus ? 1 : 0},
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected toggle status response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not update employee status. Please try again.',
        );
      }

      final dataMap = _asStringKeyMap(body['data']);
      if (dataMap == null) {
        throw const ServerException(
          message: 'Toggle status data is missing in response.',
        );
      }

      return ToggleStatusModel.fromJson(dataMap);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not update employee status. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read toggle status response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while updating employee status.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<TerminateEmployeeModel> terminateEmployee({
    required String employeeId,
    required String reason,
    required String date,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.employeeTerminate(employeeId),
        data: {
          'termination_reason': reason,
          'termination_date': date,
        },
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected terminate employee response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not terminate employee. Please try again.',
        );
      }

      return TerminateEmployeeModel.fromJson(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not terminate employee. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read terminate employee response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while terminating the employee.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<ChangeEmployeePasswordModel> changeEmployeePassword({
    required String employeeId,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.employeeChangePassword(employeeId),
        data: {
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        },
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected change password response format.',
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

      return ChangeEmployeePasswordModel.fromJson(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not change password. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read change password response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while changing the password.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<AssignEmployeeDeviceIdModel> assignEmployeeDeviceId({
    required String employeeId,
    required int deviceId,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.employeeAssignDeviceId(employeeId),
        data: {'device_id': deviceId},
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected assign device ID response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not assign device ID. Please try again.',
        );
      }

      return AssignEmployeeDeviceIdModel.fromJson(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not assign device ID. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read assign device ID response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while assigning the device ID.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<AssignEmployeeBiometricIdModel> assignEmployeeBiometricId({
    required String employeeId,
    required String biometricId,
  }) async {
    try {
      final response = await dioClient.post(
        ApiConstants.employeeAssignBiometricId(employeeId),
        data: {'biometric_id': biometricId},
      );

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected assign biometric ID response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not assign biometric ID. Please try again.',
        );
      }

      return AssignEmployeeBiometricIdModel.fromJson(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not assign biometric ID. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read assign biometric ID response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while assigning the biometric ID.',
        debugMessage: e.toString(),
      );
    }
  }

  Map<String, dynamic>? _asStringKeyMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return null;
  }
}
