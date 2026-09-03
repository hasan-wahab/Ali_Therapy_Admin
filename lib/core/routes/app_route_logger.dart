import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/utils/app_debug_logger.dart';

// ============================================================
// APP ROUTE LOGGER
// ------------------------------------------------------------
// Prints screen open / close. API logger does not cover this.
// ============================================================

class AppRouteLogger extends NavigatorObserver {
  String _nameOf(Route<dynamic>? route) {
    if (route == null) return '(none)';
    final name = route.settings.name;
    if (name != null && name.trim().isNotEmpty) return name;
    return route.settings.arguments?.toString() ?? route.runtimeType.toString();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppDebugLogger.action(
      where: 'Router',
      action: 'OPEN ${_nameOf(route)}',
      detail: 'from ${_nameOf(previousRoute)}',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    AppDebugLogger.action(
      where: 'Router',
      action: 'CLOSE ${_nameOf(route)}',
      detail: 'back to ${_nameOf(previousRoute)}',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    AppDebugLogger.action(
      where: 'Router',
      action: 'REPLACE ${_nameOf(oldRoute)} → ${_nameOf(newRoute)}',
    );
  }
}
