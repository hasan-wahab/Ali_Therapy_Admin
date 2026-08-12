import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_day_block.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_event_card.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_event_kind.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_timeline_rail.dart';

// ============================================================
// PROGRESS TIMELINE STEP
// ------------------------------------------------------------
// One timeline row: rail + stage event card.
// ============================================================

class ProgressTimelineStep extends StatelessWidget {
  const ProgressTimelineStep({
    super.key,
    required this.event,
    required this.isLast,
  });

  final ProgressDayEventData event;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProgressTimelineRail(
            accent: event.kind.accent,
            isLast: isLast,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 10.h),
              child: ProgressEventCard(
                kind: event.kind,
                timeLabel: event.timeLabel,
                staffName: event.staffName,
                status: event.status,
                highlightBorder: event.highlightBorder,
                packageLine: event.packageLine,
                startTime: event.startTime,
                endTime: event.endTime,
                duration: event.duration,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
