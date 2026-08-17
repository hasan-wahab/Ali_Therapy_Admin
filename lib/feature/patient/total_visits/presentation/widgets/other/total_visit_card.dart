import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/total_visits/presentation/widgets/other/total_visit_info_row.dart';
import 'package:ali_therapy_admin/feature/patient/total_visits/presentation/widgets/other/total_visit_type_field.dart';

// ============================================================
// TOTAL VISIT CARD
// ------------------------------------------------------------
// Visit card (no See all / See less — content is short).
// ============================================================

class TotalVisitCard extends StatelessWidget {
  const TotalVisitCard({
    super.key,
    required this.date,
    required this.type,
    required this.doctor,
    required this.stage,
    required this.amount,
  });

  final String date;
  final String type;
  final String doctor;
  final String stage;
  final String amount;

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
                          child: Text(
                            date,
                            style: AppTextStyles.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 6.h),
                    child: AppTabletFieldsGrid(
                      phoneColumns: 2,
                      tabletColumns: 2,
                      children: [
                        TotalVisitInfoRow(
                          label: 'Doctor',
                          value: doctor,
                          icon: Icons.medical_services_outlined,
                        ),
                        TotalVisitInfoRow(
                          label: 'Stage',
                          value: stage,
                          icon: Icons.timeline_outlined,
                        ),
                        TotalVisitTypeField(type: type),
                        TotalVisitInfoRow(
                          label: 'Amount',
                          value: amount,
                          icon: Icons.payments_outlined,
                          valueBold: true,
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
