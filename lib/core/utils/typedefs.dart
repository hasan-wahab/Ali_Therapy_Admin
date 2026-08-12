import 'package:ali_therapy_admin/core/errors/failures.dart';

// ============================================================
// TYPEDEFS + RESULT
// ------------------------------------------------------------
// Typedefs = short names for long types.
// Result = success OR failure wrapper (beginner-friendly).
// ============================================================

/// Future that returns either a Failure or success data.
typedef ResultFuture<T> = Future<Result<T>>;

/// Future work with no success value, but can still fail.
typedef ResultVoid = Future<Result<void>>;

/// Holds either success data or a Failure.
///
/// Beginner tip:
///   result.when(
///     success: (data) => print(data),
///     failure: (fail) => print(fail.message),
///   );
class Result<T> {
  final T? _data;
  final Failure? _failure;

  const Result._({this._data, this._failure});

  /// Create a successful result.
  factory Result.success(T data) => Result._(data: data);

  /// Create a failed result.
  factory Result.failure(Failure failure) => Result._(failure: failure);

  /// True if this result has data (no failure).
  bool get isSuccess => _failure == null;

  /// True if this result has a failure.
  bool get isFailure => _failure != null;

  /// The success data (only use when isSuccess is true).
  T get data => _data as T;

  /// The failure (only use when isFailure is true).
  Failure get failure => _failure!;

  /// Easy way to handle both cases without if/else.
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) failure,
  }) {
    if (_failure != null) {
      return failure(_failure);
    }
    return success(_data as T);
  }
}
