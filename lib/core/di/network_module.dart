import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';

// ============================================================
// NETWORK MODULE
// ------------------------------------------------------------
// Dio HTTP client for all API calls.
// Reads token from AuthLocalStorage → Bearer header.
// ============================================================

class NetworkModule implements DiModule {
  @override
  Future<void> register() async {
    sl.registerLazySingleton<DioClient>(
      () => DioClient(
        getToken: () => sl<AuthLocalStorage>().getToken(),
      ),
    );
  }
}
