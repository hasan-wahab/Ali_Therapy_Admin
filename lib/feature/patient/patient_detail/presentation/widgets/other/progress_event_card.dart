import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_event_kind.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_session_meta.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_status_chip.dart';

// ============================================================
// PROGRESS EVENT CARD
// ------------------------------------------------------------
// Stage card with left accent + soft tint (all data visible).
// History Taker / Consultant / Therapy Session open detail screens.
// ============================================================

class ProgressEventCard extends StatelessWidget {
  const ProgressEventCard({
    super.key,
    required this.kind,
    required this.timeLabel,
    required this.staffName,
    this.status,
    this.highlightBorder = false,
    this.packageLine,
    this.startTime,
    this.endTime,
    this.duration,
  });

  final ProgressEventKind kind;
  final String timeLabel;
  final String staffName;
  final ProgressEventStatus? status;
  final bool highlightBorder;
  final String? packageLine;
  final String? startTime;
  final String? endTime;
  final String? duration;

  bool get _hasSessionMeta =>
      packageLine != null &&
      packageLine!.trim().isNotEmpty &&
      startTime != null &&
      endTime != null &&
      duration != null;

  bool get _isTappable =>
      kind == ProgressEventKind.historyTaker ||
      kind == ProgressEventKind.consultant ||
      kind == ProgressEventKind.therapySession;

  void _onTap(BuildContext context) {
    switch (kind) {
      case ProgressEventKind.historyTaker:
        AppNavigation.openClinicalHistory(context);
      case ProgressEventKind.consultant:
        AppNavigation.openConsultantDetails(context);
      case ProgressEventKind.therapySession:
        AppNavigation.openTherapySessions(context);
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(10.r);

    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      child: InkWell(
        onTap: _isTappable ? () => _onTap(context) : null,
        borderRadius: radius,
        child: Ink(
          decoration: BoxDecoration(
            color: kind.softBg.withValues(
              alpha: highlightBorder ? 0.7 : 0.45,
            ),
            borderRadius: radius,
            border: Border.all(color: AppColors.border),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 3.5.w,
                  decoration: BoxDecoration(
                    color: kind.accent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kind.accent.withValues(alpha: 0.35),
                                ),
                              ),
                              child: Icon(
                                kind.icon,
                                size: AppSizes.iconSm - 4.sp,
                                color: kind.accent,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          kind.title,
                                          style:
                                              AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.textPrimary,
                                            fontWeight: FontWeight.w800,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                      if (status != null) ...[
                                        SizedBox(width: 6.w),
                                        ProgressStatusChip(status: status!),
                                      ],
                                      if (_isTappable) ...[
                                        SizedBox(width: 4.w),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: AppSizes.iconSm,
                                          color: AppColors.textMuted,
                                        ),
                                      ],
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        size: AppSizes.iconSm - 4.sp,
                                        color: AppColors.textMuted,
                                      ),
                                      SizedBox(width: 4.w),
                                      Expanded(
                                        child: Text(
                                          timeLabel,
                                          style: AppTextStyles.label.copyWith(
                                            color: AppColors.textSecondary,
                                            fontWeight: FontWeight.w500,
                                            height: 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    'By: $staffName',
                                    style: AppTextStyles.label.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (_hasSessionMeta) ...[
                          SizedBox(height: 8.h),
                          ProgressSessionMeta(
                            packageLine: packageLine!,
                            startTime: startTime!,
                            endTime: endTime!,
                            duration: duration!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
