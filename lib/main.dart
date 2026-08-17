import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/app_router.dart';
import 'package:ali_therapy_admin/core/theme/app_theme.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
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

Future<void> main() async {
  // Required before using plugins or async startup code.
  WidgetsFlutterBinding.ensureInitialized();

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

  /// Rebuild ScreenUtil when tablet rotates (portrait ↔ landscape).
  @override
  void didChangeMetrics() {
    setState(() {});
  }

  Size get _designSize {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final logical = view.physicalSize / view.devicePixelRatio;
    final landscape = logical.width > logical.height;
    return AppDevice.screenUtilDesignSize(landscape: landscape);
  }

  @override
  Widget build(BuildContext context) {
    final designSize = _designSize;

    // Phone keeps AppConstants 390×844. Tablet uses iPad Pro 11" frame.
    return ScreenUtilInit(
      key: ValueKey('${designSize.width}x${designSize.height}'),
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
