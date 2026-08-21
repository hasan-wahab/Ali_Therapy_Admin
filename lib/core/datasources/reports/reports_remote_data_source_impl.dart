import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/reports/data/assistant_manager_report_data/models/assistant_manager_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/consultation_report_data/models/consultation_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/free_consultation_report_data/models/free_consultation_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_dues_data/models/patient_dues_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_dues_history_data/models/patient_dues_history_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/package_attendance_data/models/package_attendance_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/package_attendance_detail_data/models/package_attendance_detail_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/patient_report_data/models/patient_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/receptionist_report_data/models/receptionist_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/reconsultation_report_data/models/reconsultation_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/discount_report_data/models/discount_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/in_progress_sessions_data/models/in_progress_sessions_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/insurance_panel_report_data/models/insurance_panel_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/refer_by_report_data/models/refer_by_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/report_filter_options_data/models/report_filter_options_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/therapist_report_data/models/therapist_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/data/user_activity_report_data/models/user_activity_report_model.dart';
import 'package:ali_therapy_admin/feature/reports/domain/assistant_manager_report_domain/entities/assistant_manager_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/consultation_report_domain/entities/consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/free_consultation_report_domain/entities/free_consultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_dues_domain/entities/patient_dues_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/package_attendance_domain/entities/package_attendance_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/patient_report_domain/entities/patient_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/receptionist_report_domain/entities/receptionist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/reconsultation_report_domain/entities/reconsultation_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/insurance_panel_report_domain/entities/insurance_panel_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/refer_by_report_domain/entities/refer_by_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/therapist_report_domain/entities/therapist_report_query.dart';
import 'package:ali_therapy_admin/feature/reports/domain/user_activity_report_domain/entities/user_activity_report_query.dart';

import 'reports_remote_data_source.dart';

// ============================================================
// REPORTS REMOTE DATA SOURCE (implementation)
// ============================================================

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  ReportsRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<ReportFilterOptionsModel> getFilterOptions() async {
    try {
      final response =
          await dioClient.get(ApiConstants.reportsFilterOptions);

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected filter-options response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load report filter options.',
        );
      }

      return ReportFilterOptionsModel.fromResponse(body);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load report filter options. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read filter-options response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading report filters.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<PatientDuesPageModel> getPatientDuesPage({
    required PatientDuesQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.patientDues,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected patient dues response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load patient dues.',
        );
      }

      // Response can be: { success, data: { current_page, data:[...] } }
      // or the paginate object directly at root.
      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return PatientDuesPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load patient dues. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read patient dues response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading patient dues.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<List<PatientDuesHistoryModel>> getPatientDuesHistory({
    required String patientId,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.patientDuesHistory(patientId),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected patient dues history response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load patient dues history.',
        );
      }

      final raw = body['data'];
      final list = raw is List
          ? raw
          : (raw is Map && raw['data'] is List
              ? raw['data'] as List
              : <dynamic>[]);

      return PatientDuesHistoryModel.listFromJson(list);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load patient dues history. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read patient dues history response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading patient dues history.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<ConsultationReportPageModel> getConsultationReportPage({
    required ConsultationReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.consultationReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected consultation report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load consultation report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return ConsultationReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load consultation report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read consultation report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading consultation report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<TherapistReportPageModel> getTherapistReportPage({
    required TherapistReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.therapistReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected therapist report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load therapist report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return TherapistReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load therapist report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read therapist report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading therapist report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<ReconsultationReportPageModel> getReconsultationReportPage({
    required ReconsultationReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.reconsultationReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected reconsultation report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load reconsultation report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return ReconsultationReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load reconsultation report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read reconsultation report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading reconsultation report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<FreeConsultationReportPageModel> getFreeConsultationReportPage({
    required FreeConsultationReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.freeConsultationReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected free consultation report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load free consultation report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return FreeConsultationReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message:
            'Could not load free consultation report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read free consultation report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading free consultation report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<AssistantManagerReportPageModel> getAssistantManagerReportPage({
    required AssistantManagerReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.assistantManagerReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected assistant manager report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load assistant manager report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return AssistantManagerReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message:
            'Could not load assistant manager report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read assistant manager report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading assistant manager report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<ReceptionistReportPageModel> getReceptionistReportPage({
    required ReceptionistReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.receptionistReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected receptionist report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load receptionist report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return ReceptionistReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load receptionist report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read receptionist report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading receptionist report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<PatientReportPageModel> getPatientReportPage({
    required PatientReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.patientReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected patient report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load patient report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return PatientReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load patient report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read patient report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading patient report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<PackageAttendancePageModel> getPackageAttendancePage({
    required PackageAttendanceQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.packageAttendance,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected package attendance response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load package attendance.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return PackageAttendancePageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load package attendance. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read package attendance response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading package attendance.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<PackageAttendanceDetailModel> getPackageAttendanceDetail({
    required String patientId,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.packageAttendanceDetail(patientId),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected package attendance detail response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load package attendance.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return PackageAttendanceDetailModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load package attendance. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read package attendance detail response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading package attendance.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<List<ReferByReportModel>> getReferByReport({
    required ReferByReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.referByReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected refer-by report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load refer-by report.',
        );
      }

      final raw = body['data'];
      if (raw is List) {
        return ReferByReportModel.listFromJson(raw);
      }
      if (raw is Map && raw['data'] is List) {
        return ReferByReportModel.listFromJson(raw['data'] as List);
      }

      throw const ServerException(
        message: 'Unexpected refer-by report response format.',
      );
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load refer-by report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read refer-by report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading refer-by report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<InsurancePanelReportResultModel> getInsurancePanelReport({
    required InsurancePanelReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.insurancePanelReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected insurance panel report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load insurance panel report.',
        );
      }

      Map<String, dynamic>? summaryMap = _asMap(body['summary']);
      List<dynamic>? panels;

      final raw = body['data'];
      if (raw is List) {
        panels = raw;
      } else if (raw is Map) {
        final inner = Map<String, dynamic>.from(raw);
        summaryMap = _asMap(inner['summary']) ?? summaryMap;
        final innerData = inner['data'];
        if (innerData is List) {
          panels = innerData;
        }
      }

      if (panels == null) {
        throw const ServerException(
          message: 'Unexpected insurance panel report response format.',
        );
      }

      return InsurancePanelReportResultModel.fromParts(
        summaryJson: summaryMap,
        panelsJson: panels,
      );
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load insurance panel report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read insurance panel report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading insurance panel report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<InProgressSessionsPageModel> getInProgressSessionsPage({
    required InProgressSessionsQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.inProgressSessions,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected in-progress sessions response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load in-progress sessions.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return InProgressSessionsPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load in-progress sessions. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read in-progress sessions response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading in-progress sessions.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<DiscountReportPageModel> getDiscountReportPage({
    required DiscountReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.discountReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected discount report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load discount report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return DiscountReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load discount report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read discount report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading discount report.',
        debugMessage: e.toString(),
      );
    }
  }

  @override
  Future<UserActivityReportPageModel> getUserActivityReportPage({
    required UserActivityReportQuery query,
  }) async {
    try {
      final response = await dioClient.get(
        ApiConstants.userActivityReport,
        queryParameters: query.toQueryParameters(),
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected user activity report response format.',
        );
      }

      if (body['success'] == false) {
        final msg = body['message']?.toString();
        throw BadRequestException(
          message: (msg != null && msg.isNotEmpty)
              ? msg
              : 'Could not load user activity report.',
        );
      }

      final raw = body['data'] is Map
          ? Map<String, dynamic>.from(body['data'] as Map)
          : body;

      return UserActivityReportPageModel.fromJson(raw);
    } on DioException catch (e) {
      if (e.error is AppException) throw e.error as AppException;
      throw UnknownException(
        message: 'Could not load user activity report. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read user activity report response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong loading user activity report.',
        debugMessage: e.toString(),
      );
    }
  }

  Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }
}
