import 'package:connectivity_plus/connectivity_plus.dart';

/// ============================================================
/// NETWORK INFO
/// ------------------------------------------------------------
/// Answers: "Does this device have a network interface?"
///
/// NOTE:
/// connectivity_plus = Wi‑Fi / mobile / ethernet status only.
/// It does NOT prove real internet works (captive portal, etc.).
/// Actual reachability is confirmed by a successful Dio request.
/// ============================================================

/// Contract (interface) — easy to mock in unit tests.
abstract class NetworkInfo {
  /// True if Wi‑Fi / mobile / ethernet is ON (not ConnectivityResult.none).
  Future<bool> get isConnected;

  /// Waits until a network interface is available, or [timeout] elapses.
  /// Returns true if connected by the end; false if still offline.
  Future<bool> waitUntilConnected({
    Duration timeout = const Duration(seconds: 12),
  });

  /// Connected now, or becomes connected within [timeout].
  Future<bool> ensureConnected({
    Duration timeout = const Duration(seconds: 12),
  });
}

/// Real implementation using the connectivity_plus package.
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectivity);

  final Connectivity connectivity;

  @override
  Future<bool> get isConnected async {
    final List<ConnectivityResult> results =
        await connectivity.checkConnectivity();

    if (results.isEmpty) return false;
    if (results.length == 1 && results.first == ConnectivityResult.none) {
      return false;
    }

    return results.any((result) => result != ConnectivityResult.none);
  }

  @override
  Future<bool> waitUntilConnected({
    Duration timeout = const Duration(seconds: 12),
  }) async {
    if (await isConnected) return true;

    try {
      await connectivity.onConnectivityChanged
          .where(_hasUsableInterface)
          .first
          .timeout(timeout);
      // Small settle delay after interface flips on.
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return await isConnected;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> ensureConnected({
    Duration timeout = const Duration(seconds: 12),
  }) async {
    if (await isConnected) return true;
    return waitUntilConnected(timeout: timeout);
  }

  bool _hasUsableInterface(List<ConnectivityResult> results) {
    if (results.isEmpty) return false;
    return results.any((result) => result != ConnectivityResult.none);
  }
}
