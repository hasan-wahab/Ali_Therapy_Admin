import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/app_router.dart';
import 'package:ali_therapy_admin/core/theme/app_theme.dart';
import 'package:ali_therapy_admin/core/utils/app_bloc_observer.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_error_logger.dart';
import 'package:ali_therapy_admin/core/widgets/app_native_splash_view.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// MAIN
// ------------------------------------------------------------
// App entry point.
//
// Order (important):
//   1. Ensure Flutter bindings are ready
//   2. Set up dependency injection (get_it)
//   3. Call runApp()
// ============================================================

/// Removes the Android overscroll glow (rainbow) app-wide.
/// AppPullRefresh uses a teal linear indicator instead.
class _NoGlowScrollBehavior extends ScrollBehavior {
  const _NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child; // no glow
  }
}

Future<void> main() async {
  // Keep the native (Figma) white+logo splash until Flutter's first frame.
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);

  // Uncaught UI / framework errors → Debug Console with file name.
  FlutterError.onError = (details) {
    AppErrorLogger.logCrash(
      error: details.exception,
      stack: details.stack,
      where: details.library ?? 'FlutterError',
    );
    FlutterError.presentError(details);
  };

  // Uncaught Dart async errors (API, timers, …).
  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    AppErrorLogger.logCrash(
      error: error,
      stack: stack,
      where: 'Uncaught async',
    );
    return true;
  };

  Bloc.observer = AppBlocObserver();

  // Register core services (Dio, Connectivity, etc.).
  await setupInjection();

  runApp(const AliTherapyAdminApp());
}

class AliTherapyAdminApp extends StatefulWidget {
  const AliTherapyAdminApp({super.key});

  @override
  State<AliTherapyAdminApp> createState() => _AliTherapyAdminAppState();
}

class _AliTherapyAdminAppState extends State<AliTherapyAdminApp>
    with WidgetsBindingObserver {
  late Size _designSize = _readDesignSize();
  bool _nativeSplashRemoved = false;

  void _removeNativeSplash() {
    if (_nativeSplashRemoved) return;
    _nativeSplashRemoved = true;
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Phone design size never changes. Tablet only rebuilds on rotation.
  /// Keyboard / IME inset changes must NOT rebuild MaterialApp — that
  /// cancels the input connection and looks like a crash.
  static Size _readDesignSize() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final logical = view.physicalSize / view.devicePixelRatio;
    final landscape = logical.width > logical.height;
    return AppDevice.screenUtilDesignSize(landscape: landscape);
  }

  @override
  void didChangeMetrics() {
    final next = _readDesignSize();
    if (next == _designSize) return;
    setState(() => _designSize = next);
  }

  /// Keyboard size changes must not rebuild MaterialApp (that freezes login).
  /// First Android frames can be 0×0 — rebuild once the real size arrives,
  /// or ScreenUtil `.sp` becomes 0 and TextFields crash.
  static bool _screenUtilRebuildFactor(
    MediaQueryData old,
    MediaQueryData data,
  ) {
    if (old.size.isEmpty || data.size.isEmpty) {
      return old.size != data.size;
    }
    return RebuildFactors.orientation(old, data);
  }

  static bool _hasUsableSize(Size size) => size.width > 1 && size.height > 1;

  /// ScreenUtilInit can keep a 0×0 MediaQuery. Force the real view size.
  void _applyScreenUtil(BuildContext context) {
    ScreenUtil.configure(
      data: MediaQueryData.fromView(View.of(context)),
      designSize: _designSize,
      splitScreenMode: true,
      minTextAdapt: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Phone keeps AppConstants 390×844. Tablet uses iPad Pro 11" frame.
    // MaterialApp MUST be created inside [builder] so ScreenUtil is ready
    // before AppTheme uses .sp / .w / .h.
    return ScreenUtilInit(
      key: ValueKey('${_designSize.width}x${_designSize.height}'),
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      rebuildFactor: _screenUtilRebuildFactor,
      enableScaleWH: () {
        try {
          return _hasUsableSize(
            Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight),
          );
        } catch (_) {
          return false;
        }
      },
      enableScaleText: () {
        try {
          return _hasUsableSize(
            Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight),
          );
        } catch (_) {
          return false;
        }
      },
      builder: (context, child) {
        final view = View.of(context);
        final logical = view.physicalSize / view.devicePixelRatio;
        if (!_hasUsableSize(logical)) {
          // Match native splash (Figma 651:2) so the first frame stays white.
          return const AppNativeSplashView();
        }

        _applyScreenUtil(context);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _removeNativeSplash();
        });

        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          routerConfig: AppRouter.router,
          // Remove Android rainbow/glow on overscroll — our AppPullRefresh
          // shows a teal linear line instead.
          scrollBehavior: const _NoGlowScrollBehavior(),
        );
      },
    );
  }
}
