import 'package:ali_therapy_admin/core/di/all_employees_module.dart';
import 'package:ali_therapy_admin/core/di/auth_module.dart';
import 'package:ali_therapy_admin/core/di/di_module.dart';
import 'package:ali_therapy_admin/core/di/external_module.dart';
import 'package:ali_therapy_admin/core/di/network_module.dart';
import 'package:ali_therapy_admin/core/di/profile_module.dart';
import 'package:ali_therapy_admin/core/di/service_module.dart';
// HomeModule: add when dashboard API + HomeBloc are wired (see home_data / home_domain).

// ============================================================
// DI SETUP
// ------------------------------------------------------------
// All modules are stored in one LIST.
// setupCoreDi() loops over that list and registers each module.
//
// To add a new module:
//   1. Create a new file under core/di/ (implements DiModule)
//   2. Add it to the list below
// ============================================================

/// Core + feature modules — order matters.
/// External → Services → Network → Feature modules
/// (AuthLocalStorage must exist before DioClient.)
final List<DiModule> coreModules = [
  ExternalModule(),
  ServiceModule(),
  NetworkModule(),
  AuthModule(),
  AllEmployeesModule(),
  ProfileModule(),
];

/// Registers all DI modules using a list + loop.
Future<void> setupCoreDi() async {
  for (final DiModule module in coreModules) {
    await module.register();
  }
}
