import 'package:connectivity_plus/connectivity_plus.dart';

/// ============================================================
/// NETWORK INFO
/// ------------------------------------------------------------
/// Simple helper that answers one question:
///   "Does this phone / device have a network connection?"
///
/// NOTE:
/// This checks if Wi‑Fi / mobile data is ON.
/// It does NOT always mean real internet is working
/// (example: Wi‑Fi connected but no data).
/// ============================================================

/// Contract (interface) — easy to mock in unit tests.
abstract class NetworkInfo {
  /// Returns true if device is connected to Wi‑Fi or mobile data.
  Future<bool> get isConnected;
}

/// Real implementation using the connectivity_plus package.
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // connectivity_plus v6 returns a LIST of results.
    final List<ConnectivityResult> results = await connectivity
        .checkConnectivity();

    // If the list is empty OR only contains "none" → no network.
    if (results.isEmpty) return false;
    if (results.length == 1 && results.first == ConnectivityResult.none) {
      return false;
    }

    // Any other result (wifi, mobile, ethernet…) means connected.
    return results.any((result) => result != ConnectivityResult.none);
  }
}
