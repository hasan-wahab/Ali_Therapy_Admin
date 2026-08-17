import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/utils/app_constants.dart';

// ============================================================
// APP DEVICE
// ------------------------------------------------------------
// Tablet vs phone helpers. Phone UI must stay unchanged —
// use these only to branch into tablet layouts.
// Breakpoint: Material tablet (shortest side ≥ 600).
// ============================================================

class AppDevice {
  AppDevice._();

  static const double tabletMinShortestSide = 600;

  /// Call before / without BuildContext (e.g. main.dart designSize).
  static bool get isTabletDevice {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize / view.devicePixelRatio;
    return size.shortestSide >= tabletMinShortestSide;
  }

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= tabletMinShortestSide;

  static bool isPhone(BuildContext context) => !isTablet(context);

  static bool isLandscape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  /// ScreenUtil design size — phone constants never change.
  static Size screenUtilDesignSize({required bool landscape}) {
    if (!isTabletDevice) {
      return const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      );
    }
    if (landscape) {
      return const Size(
        AppConstants.tabletLandscapeDesignWidth,
        AppConstants.tabletLandscapeDesignHeight,
      );
    }
    return const Size(
      AppConstants.tabletDesignWidth,
      AppConstants.tabletDesignHeight,
    );
  }

  /// Max content width so tablet UI does not stretch edge-to-edge.
  static double contentMaxWidth(BuildContext context) {
    if (!isTablet(context)) return double.infinity;
    return isLandscape(context) ? 1000 : 720;
  }
}
