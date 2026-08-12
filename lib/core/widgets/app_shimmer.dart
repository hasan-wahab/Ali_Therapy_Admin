import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ============================================================
// APP SHIMMER (YouTube-style grey + white light sweep)
// ------------------------------------------------------------
// Wrap loading content with AppShimmer.
// Bones listen to the shared animation (works even if cards are const).
// ============================================================

class AppShimmer extends StatefulWidget {
  const AppShimmer({super.key, required this.child});

  final Widget child;

  /// Shared animation from the nearest [AppShimmer] ancestor.
  static Animation<double>? animationOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_AppShimmerScope>()
        ?.animation;
  }

  @override
  State<AppShimmer> createState() => _AppShimmerState();
}

class _AppShimmerState extends State<AppShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AppShimmerScope(animation: _controller, child: widget.child);
  }
}

class _AppShimmerScope extends InheritedWidget {
  const _AppShimmerScope({required this.animation, required super.child});

  final Animation<double> animation;

  @override
  bool updateShouldNotify(_AppShimmerScope oldWidget) {
    return oldWidget.animation != animation;
  }
}

/// Soft grey bone with moving white highlight (YouTube style).
class AppShimmerBone extends StatelessWidget {
  const AppShimmerBone({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxShape shape;

  static const Color _base = Color(0xFFE6E6E6);
  static const Color _mid = Color(0xFFF0F0F0);
  static const Color _shine = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    final animation = AppShimmer.animationOf(context);
    final radius = shape == BoxShape.circle
        ? null
        : BorderRadius.circular(borderRadius ?? 6.r);

    if (animation == null) {
      return Container(
        width: width,
        height: height ?? 12.h,
        decoration: BoxDecoration(
          color: _base,
          shape: shape,
          borderRadius: radius,
        ),
      );
    }

    // Each bone listens itself → animation always runs.
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // t: 0 → 1, slide highlight left → right across the bone.
        final t = animation.value;
        final slide = (t * 2) - 1; // -1.0 → 1.0

        return Container(
          width: width,
          height: height ?? 12.h,
          decoration: BoxDecoration(
            shape: shape,
            borderRadius: radius,
            gradient: LinearGradient(
              begin: Alignment(slide - 1, 0),
              end: Alignment(slide + 1, 0),
              colors: const [_base, _base, _mid, _shine, _mid, _base, _base],
              stops: const [0.0, 0.30, 0.42, 0.50, 0.58, 0.70, 1.0],
            ),
          ),
        );
      },
    );
  }
}
