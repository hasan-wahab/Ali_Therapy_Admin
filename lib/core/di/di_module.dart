// ============================================================
// DI MODULE (base)
// ------------------------------------------------------------
// Every DI module must follow this contract.
// This lets us keep all modules in one LIST and loop over them.
//
// Example:
//   class AuthModule implements DiModule { ... }
// ============================================================

/// Common contract for every DI module.
abstract class DiModule {
  /// Register all dependencies for this module.
  Future<void> register();
}
