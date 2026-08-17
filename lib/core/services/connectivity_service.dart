import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:ali_therapy_admin/core/network/network_info.dart';

/// ============================================================
/// CONNECTIVITY SERVICE
/// ------------------------------------------------------------
/// Wrapper around NetworkInfo + Connectivity stream.
///
/// Use:
///   - await connectivityService.hasConnection
///   - await connectivityService.waitForConnection()
///   - connectivityService.onConnectivityChanged
/// ============================================================

class ConnectivityService {
  ConnectivityService({
    required this.networkInfo,
    required this.connectivity,
  });

  final NetworkInfo networkInfo;
  final Connectivity connectivity;

  /// One-time check: is a network interface available right now?
  Future<bool> get hasConnection => networkInfo.isConnected;

  /// Wait until Wi‑Fi / mobile is back (or timeout).
  Future<bool> waitForConnection({
    Duration timeout = const Duration(seconds: 12),
  }) {
    return networkInfo.waitUntilConnected(timeout: timeout);
  }

  /// Connected now, or becomes connected within [timeout].
  Future<bool> ensureConnection({
    Duration timeout = const Duration(seconds: 12),
  }) {
    return networkInfo.ensureConnected(timeout: timeout);
  }

  /// Stream that fires when Wi‑Fi / mobile status changes.
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return connectivity.onConnectivityChanged;
  }
}
