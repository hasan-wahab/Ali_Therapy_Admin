import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ali_therapy_admin/core/utils/app_debug_logger.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';

// ============================================================
// APP BLOC OBSERVER
// ------------------------------------------------------------
// Debug: event + new state (not API — that is PrettyDioLogger).
// Errors still go to AppErrorLogger.
// ============================================================

class AppBlocObserver extends BlocObserver {
  String _short(Object? value) {
    return AppDebugLogger.clip(value.toString(), max: 180);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    AppDebugLogger.action(
      where: bloc.runtimeType.toString(),
      action: 'EVENT ${_short(event)}',
    );
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    AppDebugLogger.action(
      where: bloc.runtimeType.toString(),
      action: 'STATE ${_short(change.nextState)}',
      detail: 'from ${_short(change.currentState)}',
    );
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppErrorLogger.logCrash(
      error: error,
      stack: stackTrace,
      where: 'Bloc ${bloc.runtimeType}',
    );
    super.onError(bloc, error, stackTrace);
  }
}
