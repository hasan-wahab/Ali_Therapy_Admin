import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'reports_remote_data_source.dart';

// ============================================================
// REPORTS REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// Dio calls go here when endpoints are ready.
// ============================================================

class ReportsRemoteDataSourceImpl implements ReportsRemoteDataSource {
  final DioClient dioClient;

  ReportsRemoteDataSourceImpl({required this.dioClient});

  // TODO: implement API methods using dioClient + ApiConstants.
}
