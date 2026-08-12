import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_day_header.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_event_kind.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_status_chip.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_timeline_step.dart';

// ============================================================
// PROGRESS DAY BLOCK
// ------------------------------------------------------------
// Visit card with soft header + vertical timeline stages.
// ============================================================

class ProgressDayEventData {
  const ProgressDayEventData({
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
}

class ProgressDayBlock extends StatelessWidget {
  const ProgressDayBlock({
    super.key,
    required this.visitTitle,
    required this.dateTime,
    required this.visitType,
    required this.events,
    this.status = ProgressEventStatus.completed,
  });

  final String visitTitle;
  final String dateTime;
  final String visitType;
  final ProgressEventStatus status;
  final List<ProgressDayEventData> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProgressDayHeader(
            visitTitle: visitTitle,
            dateTime: dateTime,
            visitType: visitType,
            status: status,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < events.length; i++)
                  ProgressTimelineStep(
                    event: events[i],
                    isLast: i == events.length - 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
