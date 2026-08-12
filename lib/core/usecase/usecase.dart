// ============================================================
// USE CASE BASE
// ------------------------------------------------------------
// Every use case follows this shape.
// Type parameter Output = success return type
// Params = input values
// ============================================================

import 'package:ali_therapy_admin/core/utils/typedefs.dart';

/// Base class for all use cases.
abstract class UseCase<Output, Params> {
  ResultFuture<Output> call(Params params);
}

/// Use when a use case needs no input.
class NoParams {
  const NoParams();
}
