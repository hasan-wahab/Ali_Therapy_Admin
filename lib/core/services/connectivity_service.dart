import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:ali_therapy_admin/core/network/network_info.dart';

/// ============================================================
/// CONNECTIVITY SERVICE
/// ------------------------------------------------------------
/// A small wrapper around NetworkInfo + Connectivity stream.
///
/// Use cases:
///   - Check once:  await connectivityService.hasConnection
///   - Listen live: connectivityService.onConnectivityChanged
/// ============================================================

class ConnectivityService {
  final NetworkInfo networkInfo;
  final Connectivity connectivity;

  ConnectivityService({
    required this.networkInfo,
    required this.connectivity,
  });

  /// One-time check: is the device online right now?
  Future<bool> get hasConnection => networkInfo.isConnected;

  /// Stream that fires every time Wi‑Fi / mobile status changes.
  /// Example:
  ///   connectivityService.onConnectivityChanged.listen((results) {
  ///     print(results);
  ///   });
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return connectivity.onConnectivityChanged;
  }
}
