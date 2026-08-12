import 'package:get_it/get_it.dart';

// ============================================================
// SERVICE LOCATOR
// ------------------------------------------------------------
// Global get_it container.
// Use this same `sl` everywhere.
//
// Example:
//   final dio = sl<DioClient>();
// ============================================================

/// Global service locator (short name: sl).
final GetIt sl = GetIt.instance;
