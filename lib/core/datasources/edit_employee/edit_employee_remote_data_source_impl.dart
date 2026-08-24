import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/edit_employee/edit_employee_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/data/edit_employee_data/models/edit_employee_json_helpers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/data/edit_employee_data/models/edit_employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/data/edit_employee_data/models/update_employee_model.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_form_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';

// ============================================================
// EDIT EMPLOYEE REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// GET  employees/{id}  (same as View — existing details)
// POST employees/update/{id}
// ============================================================

class EditEmployeeRemoteDataSourceImpl implements EditEmployeeRemoteDataSource {
  EditEmployeeRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<EditEmployeeModel> getEditEmployee({
    required String employeeId,
  }) async {
    try {
      final response = await _getEmployeePayload(employeeId);
      final filtersMap = await _tryLoadFilters();
      return EditEmployeeModel.fromResponse(
        response.data,
        filtersMap: filtersMap,
      );
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load employee. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read employee edit response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading the employee.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<UpdateEmployeeModel> updateEmployee({
    required String employeeId,
    required EditEmployeeFormEntity form,
    required EditEmployeeOptionsEntity options,
  }) async {
    try {
      final body = UpdateEmployeeModel.requestPayload(
        form: form,
        options: options,
      );
      final response = await dioClient.post(
        ApiConstants.employeeUpdate(employeeId),
        data: body,
      );

      final map = EditEmployeeJsonHelpers.mapOrNull(response.data) ??
          <String, dynamic>{};
      if (map['success'] == false) {
        final fromErrors = _flattenErrors(map['errors']);
        final message = fromErrors ?? map['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not update employee. Please try again.',
        );
      }

      return UpdateEmployeeModel.fromJson(map);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not update employee. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read update employee response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while updating the employee.',
        debugMessage: e.toString(),
      );
    }
  }

  Future<Response> _getEmployeePayload(String employeeId) async {
    try {
      // Same endpoint as employee View so the form starts with that data.
      return await dioClient.get(ApiConstants.employeeShow(employeeId));
    } on DioException catch (e) {
      if (!_isNotFound(e)) rethrow;
      return dioClient.get(ApiConstants.employeeEdit(employeeId));
    }
  }

  Future<Map<String, dynamic>?> _tryLoadFilters() async {
    try {
      final response = await dioClient.get(ApiConstants.employeesFiltersData);
      final root = EditEmployeeJsonHelpers.mapOrNull(response.data);
      if (root == null) return null;
      return EditEmployeeJsonHelpers.mapOrNull(root['data']) ?? root;
    } catch (_) {
      return null;
    }
  }

  bool _isNotFound(DioException e) {
    if (e.response?.statusCode == 404) return true;
    final error = e.error;
    return error is NotFoundException;
  }

  String? _flattenErrors(dynamic errors) {
    if (errors is! Map) return null;
    final parts = <String>[];
    for (final value in errors.values) {
      if (value is List && value.isNotEmpty) {
        final first = value.first?.toString().trim() ?? '';
        if (first.isNotEmpty) parts.add(first);
      } else if (value is String && value.trim().isNotEmpty) {
        parts.add(value.trim());
      }
    }
    if (parts.isEmpty) return null;
    return parts.join('\n');
  }
}
