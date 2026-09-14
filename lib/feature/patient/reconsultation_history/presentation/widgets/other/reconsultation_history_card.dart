import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_field.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_item.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_score.dart';
import 'package:ali_therapy_admin/feature/patient/reconsultation_history/presentation/widgets/other/reconsultation_history_view_button.dart';

// ============================================================
// RECONSULTATION HISTORY CARD
// ------------------------------------------------------------
// Short card (no See all / See less).
// ============================================================

class ReconsultationHistoryCard extends StatelessWidget {
  const ReconsultationHistoryCard({
    super.key,
    required this.item,
    required this.onViewReport,
  });

  final ReconsultationHistoryItem item;
  final VoidCallback onViewReport;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4.w, color: AppColors.primary),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
                    color: AppColors.primaryLight,
                    child: Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            size: AppSizes.iconSm,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.date,
                                style: AppTextStyles.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                item.time,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTabletFieldsGrid(
                          phoneColumns: 1,
                          tabletColumns: 2,
                          children: [
                            ReconsultationHistoryField(
                              label: 'Consultant',
                              value: '${item.consultant}\n${item.clinic}',
                              icon: Icons.medical_services_outlined,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 30.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(
                                      Icons.monitor_heart_outlined,
                                      size: 15.sp,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: ReconsultationHistoryScore(
                                      score: item.recoveryScore,
                                      showLabel: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ReconsultationHistoryField(
                              label: 'Patient Complaint',
                              value: item.complaint,
                              icon: Icons.chat_bubble_outline_rounded,
                              maxLines: 3,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ReconsultationHistoryViewButton(
                            onTap: onViewReport,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
