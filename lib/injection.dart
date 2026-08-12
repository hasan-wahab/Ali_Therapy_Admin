import 'package:ali_therapy_admin/core/di/di_setup.dart';

// ============================================================
// INJECTION (app entry for DI)
// ------------------------------------------------------------
// main.dart imports this file.
// The actual modules live in `lib/core/di/`.
//
// Steps:
//   1. Call setupInjection() in main() before runApp()
//   2. Later use:  `sl<DioClient>()`  to get the same object
// ============================================================

// Re-export `sl` so other files can import injection.dart
// and still use the service locator.
export 'package:ali_therapy_admin/core/di/service_locator.dart';

/// Sets up dependency injection when the app starts.
Future<void> setupInjection() async {
  await setupCoreDi();
}
