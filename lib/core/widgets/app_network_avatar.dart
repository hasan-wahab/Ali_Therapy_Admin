import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// APP NETWORK AVATAR (shared)
// ------------------------------------------------------------
// Loads profile images from the API server.
// Storage URLs need: Authorization: Bearer <token>
// (same as doctor_app). On fail → person icon.
// ============================================================

class AppNetworkAvatar extends StatelessWidget {
  const AppNetworkAvatar({
    super.key,
    this.imageUrl,
    this.radius,
    this.iconSize,
  });

  final String? imageUrl;

  /// Circle radius. Default: 22.r
  final double? radius;

  /// Placeholder icon size. Default: AppSizes.iconMd
  final double? iconSize;

  bool get _hasUrl {
    final url = imageUrl?.trim();
    return url != null && url.isNotEmpty && url != '_';
  }

  Map<String, String>? _authHeaders() {
    final token = sl<AuthLocalStorage>().getTokenSync();
    if (token == null) return null;
    return {'Authorization': 'Bearer $token'};
  }

  Widget _placeholder({required double r, required double icon}) {
    return CircleAvatar(
      radius: r,
      backgroundColor: AppColors.primaryLight,
      child: Icon(
        Icons.person_rounded,
        color: AppColors.primary,
        size: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = radius ?? 22.r;
    final icon = iconSize ?? AppSizes.iconMd;

    if (!_hasUrl) {
      return _placeholder(r: r, icon: icon);
    }

    return ClipOval(
      child: SizedBox(
        width: r * 2,
        height: r * 2,
        child: Image.network(
          imageUrl!.trim(),
          fit: BoxFit.cover,
          headers: _authHeaders(),
          errorBuilder: (context, error, stackTrace) {
            // Server 403 / broken file → soft fallback (no red error).
            return ColoredBox(
              color: AppColors.primaryLight,
              child: Icon(
                Icons.person_rounded,
                color: AppColors.primary,
                size: icon,
              ),
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return ColoredBox(
              color: AppColors.primaryLight,
              child: Center(
                child: SizedBox(
                  width: icon,
                  height: icon,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
