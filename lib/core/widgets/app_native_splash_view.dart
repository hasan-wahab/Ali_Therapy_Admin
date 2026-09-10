import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_constants.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';

// ============================================================
// APP NATIVE SPLASH VIEW
// ------------------------------------------------------------
// Matches Figma 651:2 native launch screen so Flutter's first
// frame does not flash a different layout.
// Phone: 176pt center logo, ~112×37 branding, 32pt bottom inset.
// Tablet: larger logo + branding, more bottom inset.
// ============================================================

class AppNativeSplashView extends StatelessWidget {
  const AppNativeSplashView({super.key});

  static const _phoneLogo = 176.0;
  static const _phoneBrandHeight = 42.0;
  static const _phoneBottomInset = 32.0;

  static const _tabletLogo = 240.0;
  static const _tabletBrandHeight = 64.0;
  static const _tabletBottomInset = 48.0;

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDevice.isTablet(context);
    final logoSize = isTablet ? _tabletLogo : _phoneLogo;
    final brandHeight = isTablet ? _tabletBrandHeight : _phoneBrandHeight;
    final bottomInset = isTablet ? _tabletBottomInset : _phoneBottomInset;

    return ColoredBox(
      color: AppColors.surface,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: logoSize,
                height: logoSize,
                child: Image.asset(
                  AppConstants.nativeSplashLogo,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: SizedBox(
              height: brandHeight,
              child: Image.asset(
                AppConstants.nativeSplashBranding,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
