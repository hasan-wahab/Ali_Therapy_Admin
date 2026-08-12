import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'employees_remote_data_source.dart';

// ============================================================
// EMPLOYEES REMOTE DATA SOURCE (implementation)
// ------------------------------------------------------------
// Dio calls go here when endpoints are ready.
// ============================================================

class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  final DioClient dioClient;

  EmployeesRemoteDataSourceImpl({required this.dioClient});

  // TODO: implement API methods using dioClient + ApiConstants.
}
