import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';

// ============================================================
// APP TABLET SAFE AREA
// ------------------------------------------------------------
// SafeArea + optional tablet max-width center.
// Same call-site paren depth as SafeArea — swap name only.
// Mobile: identical to SafeArea(child: …).
// ============================================================

class AppTabletSafeArea extends StatelessWidget {
  const AppTabletSafeArea({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!AppDevice.isTablet(context)) {
      return SafeArea(child: child);
    }

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: AppDevice.contentMaxWidth(context),
          ),
          child: child,
        ),
      ),
    );
  }
}
