import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';
import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';
import 'package:ali_therapy_admin/core/services/connectivity_service.dart';
import 'package:ali_therapy_admin/core/services/image_picker_service.dart';

// ============================================================
// SERVICE MODULE
// ------------------------------------------------------------
// App services are registered here:
//   - AuthLocalStorage   → save / read login token
//   - ConnectivityService → live network stream
//   - ImagePickerService  → gallery / camera
// ============================================================

class ServiceModule implements DiModule {
  @override
  Future<void> register() async {
    // Must be before DioClient (NetworkModule uses getToken).
    sl.registerLazySingleton<AuthLocalStorage>(
      () => AuthLocalStorage(sl<SharedPreferences>()),
    );

    sl.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(
        networkInfo: sl<NetworkInfo>(),
        connectivity: sl<Connectivity>(),
      ),
    );

    sl.registerLazySingleton<ImagePickerService>(
      () => ImagePickerService(),
    );
  }
}
