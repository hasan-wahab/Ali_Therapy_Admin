import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/widgets/app_network_avatar.dart';

// ============================================================
// EMPLOYEE CARD AVATAR
// ------------------------------------------------------------
// Uses shared AppNetworkAvatar (Bearer token + error fallback).
// ============================================================

class EmployeeCardAvatar extends StatelessWidget {
  const EmployeeCardAvatar({
    super.key,
    this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return AppNetworkAvatar(
      imageUrl: imageUrl,
      radius: 22.r,
      iconSize: AppSizes.iconMd,
    );
  }
}
