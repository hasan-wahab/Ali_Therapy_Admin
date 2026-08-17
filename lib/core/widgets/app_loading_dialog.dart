import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_keyboard.dart';

// ============================================================
// APP LOADING (shared — whole app)
// ------------------------------------------------------------
// Frosted glass pill + dual rotating rings (brand teal).
// No dialog card — one look everywhere.
//
// Use:
//   if (isLoading) AppLoadingOverlay(message: 'Signing in...')
// ============================================================

class AppLoadingDialog {
  AppLoadingDialog._();

  static Future<void> show(
    BuildContext context, {
    String message = 'Please wait...',
    String? subtitle,
  }) {
    AppKeyboard.dismiss();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) {
        return PopScope(
          canPop: false,
          child: AppLoadingOverlay(
            message: message,
            subtitle: subtitle,
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
  }
}

// ============================================================
// APP LOADING OVERLAY
// ============================================================

class AppLoadingOverlay extends StatefulWidget {
  const AppLoadingOverlay({
    super.key,
    required this.message,
    this.subtitle,
  });

  final String message;
  final String? subtitle;

  @override
  State<AppLoadingOverlay> createState() => _AppLoadingOverlayState();
}

class _AppLoadingOverlayState extends State<AppLoadingOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    AppKeyboard.dismiss();
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
    final detail = widget.subtitle ?? 'Please wait';

    // Material is required: overlay often sits in a Stack *outside* Scaffold
    // (e.g. logout). Without it, Text shows yellow double underlines.
    return AbsorbPointer(
      child: Material(
        type: MaterialType.transparency,
        child: ColoredBox(
          // Soft teal wash — matches brand, not plain gray.
          color: AppColors.primary.withValues(alpha: 0.22),
          child: Center(
            child: Container(
              width: 220.w,
              padding: EdgeInsets.fromLTRB(22.w, 28.h, 22.w, 24.h),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.18),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.22),
                    blurRadius: 28.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dual-ring brand spinner.
                  SizedBox(
                    width: 68.w,
                    height: 68.w,
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _DualRingPainter(
                            progress: _controller.value,
                          ),
                          child: child,
                        );
                      },
                      child: Center(
                        child: Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    detail,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Soft progress dots.
                  _PulseDots(controller: _controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// Dual rotating arcs (outer + inner, opposite directions)
// ============================================================

class _DualRingPainter extends CustomPainter {
  _DualRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 2.w;
    final innerRadius = size.width / 2 - 12.w;

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.w
      ..color = AppColors.primary.withValues(alpha: 0.12)
      ..strokeCap = StrokeCap.round;

    final outerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2.w
      ..color = AppColors.primary
      ..strokeCap = StrokeCap.round;

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6.w
      ..color = AppColors.primaryDark
      ..strokeCap = StrokeCap.round;

    // Soft tracks.
    canvas.drawCircle(center, outerRadius, trackPaint);
    canvas.drawCircle(center, innerRadius, trackPaint);

    // Outer arc rotates clockwise.
    final outerStart = progress * math.pi * 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius),
      outerStart,
      math.pi * 1.15,
      false,
      outerPaint,
    );

    // Inner arc rotates counter-clockwise.
    final innerStart = -progress * math.pi * 2 + math.pi / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius),
      innerStart,
      math.pi * 0.9,
      false,
      innerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _DualRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ============================================================
// Three soft pulse dots under the message
// ============================================================

class _PulseDots extends StatelessWidget {
  const _PulseDots({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            // Stagger each dot so they pulse in sequence.
            final wave = (controller.value + (index * 0.22)) % 1.0;
            final scale = 0.55 + (math.sin(wave * math.pi) * 0.45);
            final opacity = 0.35 + (math.sin(wave * math.pi) * 0.65);

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity.clamp(0.0, 1.0),
                  child: Container(
                    width: 7.w,
                    height: 7.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
