import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/app_router.dart';
import 'package:ali_therapy_admin/core/theme/app_theme.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';
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

class AliTherapyAdminApp extends StatelessWidget {
  const AliTherapyAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit scales the UI for different phone sizes.
    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,

          // Theme (colors, buttons, inputs…)
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.light,

          // Copyable text: SelectionArea is in AppRouter ShellRoute
          // (must be under Navigator Overlay — not here).
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
