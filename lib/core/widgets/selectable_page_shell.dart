import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// SELECTABLE PAGE SHELL
// ------------------------------------------------------------
// Wraps every routed screen so text can be selected / copied.
// Must sit under Navigator Overlay (used by ShellRoute).
// Shows a clear teal highlight so users see what is selected.
// ============================================================

class SelectablePageShell extends StatelessWidget {
  const SelectablePageShell({
    super.key,
    required this.child,
  });

  final Widget child;

  /// Visible selection fill (teal tint).
  static final Color _selectionFill =
      AppColors.primary.withValues(alpha: 0.35);

  @override
  Widget build(BuildContext context) {
    return DefaultSelectionStyle(
      selectionColor: _selectionFill,
      cursorColor: AppColors.primary,
      child: Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: _selectionFill,
            selectionHandleColor: AppColors.primary,
            cursorColor: AppColors.primary,
          ),
        ),
        child: SelectionArea(
          selectionControls: materialTextSelectionControls,
          child: child,
        ),
      ),
    );
  }
}
