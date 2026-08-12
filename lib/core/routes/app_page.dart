import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ============================================================
// APP PAGE TRANSITIONS
// ------------------------------------------------------------
// Shared go_router page animation for screen navigation.
// ============================================================

class AppPage {
  AppPage._();

  static const Duration _forward = Duration(milliseconds: 280);
  static const Duration _reverse = Duration(milliseconds: 240);

  /// Soft slide-from-right + fade for push / pop.

  static CustomTransitionPage<void> slide(GoRouterState state, Widget child) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: _forward,
      reverseTransitionDuration: _reverse,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
          reverseCurve: Curves.linear,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.08, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
