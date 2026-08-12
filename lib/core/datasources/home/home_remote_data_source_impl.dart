import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'home_remote_data_source.dart';

// ============================================================
// HOME REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// Dio calls go here when endpoints are ready.
// ============================================================

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl({required this.dioClient});

  // TODO: implement API methods using dioClient + ApiConstants.
}
