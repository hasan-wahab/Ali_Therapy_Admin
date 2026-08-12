import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// APP PULL REFRESH (shared)
// ------------------------------------------------------------
// Reusable pull-to-refresh for any scroll screen.
// - List does NOT drag down
// - Thin loader on top of the scroll area
// - UI only calls: AppPullRefresh(onRefresh: ..., child: ...)
//
// Example:
//   AppPullRefresh(
//     onRefresh: () => context.read<SomeBloc>().pullRefresh(),
//     child: ListView(...),
//   )
// ============================================================

class AppPullRefresh extends StatefulWidget {
  const AppPullRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
    this.enabled = true,
    this.pullThreshold = 70,
  });

  /// Async work to run on pull (API / bloc refresh).
  final Future<void> Function() onRefresh;

  /// Must be a scrollable (ListView / CustomScrollView / ...).
  final Widget child;

  /// Set false during first-load skeleton, etc.
  final bool enabled;

  /// How far user must overscroll at top to trigger refresh.
  final double pullThreshold;

  @override
  State<AppPullRefresh> createState() => _AppPullRefreshState();
}

class _AppPullRefreshState extends State<AppPullRefresh> {
  double _pullDistance = 0;
  bool _isRefreshing = false;

  Future<void> _startRefresh() async {
    if (_isRefreshing || !widget.enabled) return;

    setState(() {
      _isRefreshing = true;
      _pullDistance = 0;
    });

    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (!widget.enabled || _isRefreshing) return false;

    if (notification is OverscrollNotification) {
      final atTop = notification.metrics.pixels <= 0;
      final pullingDown = notification.overscroll < 0;
      if (atTop && pullingDown) {
        _pullDistance += -notification.overscroll;
        if (_pullDistance >= widget.pullThreshold) {
          _startRefresh();
        }
      }
      return false;
    }

    if (notification is ScrollUpdateNotification &&
        notification.metrics.pixels > 0) {
      _pullDistance = 0;
    }
    if (notification is ScrollEndNotification) {
      _pullDistance = 0;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScrollNotification,
            child: widget.child,
          ),
        ),
        if (_isRefreshing)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              minHeight: 2.h,
              color: AppColors.primary,
              backgroundColor: AppColors.primaryLight,
            ),
          ),
      ],
    );
  }
}
