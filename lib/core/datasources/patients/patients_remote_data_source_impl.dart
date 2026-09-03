import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/data/all_patients_data/models/patient_model.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/data/all_patients_data/models/patients_page_model.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/patients_list_query.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/data/patient_detail_data/models/patient_detail_model.dart';

// ============================================================
// PATIENTS REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// GET .../api/admin/patients?page=N
// Supports Laravel paginate + older list shapes.
// ============================================================

class PatientsRemoteDataSourceImpl implements PatientsRemoteDataSource {
  PatientsRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<PatientsPageModel> getPatientsPage({
    required PatientsListQuery query,
  }) async {
    try {
      final params = query.toQueryParameters();
      final response = await dioClient.get(
        ApiConstants.patients,
        queryParameters: params.isEmpty ? null : params,
      );

      return _parsePage(response.data, requestedPage: query.page);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load patients. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read patients response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading patients.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<PatientDetailModel> getPatientFullView({
    required String patientId,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.patientFullView(patientId),
      );

      return _parseFullView(response.data);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load patient detail. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read patient detail response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading patient detail.',
        debugMessage: e.toString(),
      );
    }
  }

  PatientDetailModel _parseFullView(dynamic raw) {
    final body = _asStringKeyMap(raw);
    if (body == null) {
      throw const ServerException(
        message: 'Unexpected patient detail response format.',
      );
    }

    if (body['success'] == false) {
      final message = body['message']?.toString();
      throw BadRequestException(
        message: (message != null && message.isNotEmpty)
            ? message
            : 'Could not load patient detail. Please try again.',
      );
    }

    return PatientDetailModel.fromJson(body);
  }

  PatientsPageModel _parsePage(dynamic raw, {required int requestedPage}) {
    if (raw is List) {
      return PatientsPageModel.fromList(PatientModel.listFromJson(raw));
    }

    final body = _asStringKeyMap(raw);
    if (body == null) {
      throw const ServerException(
        message: 'Unexpected patients response format.',
      );
    }

    if (body['success'] == false) {
      final message = body['message']?.toString();
      throw BadRequestException(
        message: (message != null && message.isNotEmpty)
            ? message
            : 'Could not load patients. Please try again.',
      );
    }

    // { success, data: { current_page, data: [...] } }
    final data = body['data'];
    final dataMap = _asStringKeyMap(data);
    if (dataMap != null && dataMap['data'] is List) {
      return PatientsPageModel.fromJson(dataMap);
    }

    // Laravel paginate at root: { current_page, data: [...] }
    if (body['data'] is List && body.containsKey('current_page')) {
      return PatientsPageModel.fromJson(body);
    }

    if (data is List) {
      return PatientsPageModel.fromList(PatientModel.listFromJson(data));
    }

    if (body['patients'] is List) {
      return PatientsPageModel.fromList(
        PatientModel.listFromJson(body['patients']),
      );
    }

    throw ServerException(
      message: 'Patients list is missing in the response.',
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
