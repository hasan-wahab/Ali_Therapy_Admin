import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/patients/patients_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/data/all_patients_data/models/patient_model.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/data/all_patients_data/models/patients_page_model.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/domain/all_patients_domain/entities/patients_list_query.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/data/patient_detail_data/models/patient_detail_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/create_patient_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_edit_form_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_form_data_model.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_create_form_entity.dart';

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

  @override
  Future<PatientEditFormModel> getPatientDetails({
    required String patientId,
  }) async {
    try {
      // Full View is the known-working payload (same as Patient Detail).
      final viewResponse = await dioClient.get(
        ApiConstants.patientFullView(patientId),
      );
      final fromView = _parsePatientEdit(viewResponse.data);
      final fromShow = await _tryLoadPatientShow(patientId);
      if (fromShow == null) return fromView;
      return fromView.mergedWith(fromShow);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load patient. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read patient details response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading the patient.',
        debugMessage: e.toString(),
      );
    }
  }

  PatientEditFormModel _parsePatientEdit(dynamic raw) {
    final body = _asStringKeyMap(raw);
    if (body == null) {
      throw const ServerException(
        message: 'Unexpected patient details response format.',
      );
    }
    if (body['success'] == false) {
      final message = body['message']?.toString();
      throw BadRequestException(
        message: (message != null && message.isNotEmpty)
            ? message
            : 'Could not load patient. Please try again.',
      );
    }
    return PatientEditFormModel.fromResponse(body);
  }

  /// Extra registration fields (father name, city, marital…) if show exists.
  Future<PatientEditFormModel?> _tryLoadPatientShow(String patientId) async {
    for (final path in <String>[
      ApiConstants.patientDetails(patientId),
      'patients/$patientId',
    ]) {
      try {
        final response = await dioClient.get(path);
        final model = _parsePatientEdit(response.data);
        if (model.name.isNotEmpty ||
            model.fatherHusbandName.isNotEmpty ||
            model.city.isNotEmpty) {
          return model;
        }
      } catch (_) {
        // Show is optional — Full View already loaded.
      }
    }
    return null;
  }

  @override
  Future<PatientFormDataModel> getPatientFormData() async {
    try {
      final response = await dioClient.get(ApiConstants.patientsFormData);

      final body = _asStringKeyMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected patient form-data response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not load patient form options. Please try again.',
        );
      }

      return PatientFormDataModel.fromResponse(body);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load patient form options. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read patient form-data response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading patient form options.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<CreatePatientModel> createPatient({
    required PatientCreateFormEntity form,
  }) async {
    try {
      final body = CreatePatientModel.requestPayload(form: form);
      final response = await dioClient.post(
        ApiConstants.patientsCreate,
        data: body,
      );

      final map = _asStringKeyMap(response.data) ?? <String, dynamic>{};
      if (map['success'] == false) {
        final fromErrors = _flattenErrors(map['errors']);
        final message = fromErrors ?? map['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not register patient. Please try again.',
        );
      }

      return CreatePatientModel.fromJson(map);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not register patient. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read create patient response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while registering the patient.',
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
