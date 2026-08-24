import 'package:dio/dio.dart';

import 'package:ali_therapy_admin/core/datasources/home/home_remote_data_source.dart';
import 'package:ali_therapy_admin/core/errors/exceptions.dart';
import 'package:ali_therapy_admin/core/network/api_constants.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/feature/home/data/home_data/models/dashboard_model.dart';
import 'package:ali_therapy_admin/feature/home/domain/home_domain/entities/dashboard_overview_query.dart';

// ============================================================
// HOME REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// GET dashboard/overview (first load: no query params)
// ============================================================

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<DashboardModel> getOverview({
    required DashboardOverviewQuery query,
  }) async {
    try {
      final params = query.toQueryParameters();
      final response = await dioClient.get(
        ApiConstants.dashboardOverview,
        queryParameters: params.isEmpty ? null : params,
      );

      final body = _asMap(response.data);
      if (body == null) {
        throw const ServerException(
          message: 'Unexpected dashboard overview response format.',
        );
      }

      if (body['success'] == false) {
        final message = body['message']?.toString();
        throw BadRequestException(
          message: (message != null && message.isNotEmpty)
              ? message
              : 'Could not load dashboard overview. Please try again.',
        );
      }

      final data = _asMap(body['data']) ?? body;
      return DashboardModel.fromJson(data);
    } on DioException catch (e) {
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw UnknownException(
        message: 'Could not load dashboard overview. Please try again.',
        debugMessage: e.message,
      );
    } on AppException {
      rethrow;
    } on FormatException catch (e) {
      throw ServerException(
        message: 'Could not read dashboard overview response.',
        debugMessage: e.message,
      );
    } catch (e) {
      throw UnknownException(
        message: 'Something went wrong while loading dashboard overview.',
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
