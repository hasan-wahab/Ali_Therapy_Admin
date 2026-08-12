import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'patients_remote_data_source.dart';

// ============================================================
// PATIENTS REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// Dio calls go here when endpoints are ready.
// ============================================================

class PatientsRemoteDataSourceImpl implements PatientsRemoteDataSource {
  final DioClient dioClient;

  PatientsRemoteDataSourceImpl({required this.dioClient});

  // TODO: implement API methods using dioClient + ApiConstants.
}
