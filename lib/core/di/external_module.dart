import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/service_locator.dart';
import 'package:ali_therapy_admin/core/network/network_info.dart';

// ============================================================
// EXTERNAL MODULE
// ------------------------------------------------------------
// Third-party packages + basic network check.
//
// Order:
//   EXTERNAL → SERVICES → NETWORK → FEATURE modules
// ============================================================

class ExternalModule implements DiModule {
  @override
  Future<void> register() async {
    // Used to check Wi‑Fi / mobile network status.
    sl.registerLazySingleton<Connectivity>(() => Connectivity());

    // Simple online / offline helper (needed by services + auth).
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<Connectivity>()),
    );

    // Device key/value storage (token, saved login JSON).
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => prefs);
  }
}
