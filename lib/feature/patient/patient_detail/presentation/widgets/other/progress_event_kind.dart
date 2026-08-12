import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';

// ============================================================
// PROGRESS EVENT KIND
// ------------------------------------------------------------
// Accent + icon for each visit stage (app colors only).
// ============================================================

enum ProgressEventKind {
  reception,
  assistantManager,
  historyTaker,
  consultant,
  reconsultation,
  therapySession,
}

extension ProgressEventKindX on ProgressEventKind {
  String get title {
    switch (this) {
      case ProgressEventKind.reception:
        return 'Reception';
      case ProgressEventKind.assistantManager:
        return 'Assistant Manager';
      case ProgressEventKind.historyTaker:
        return 'History Taker';
      case ProgressEventKind.consultant:
        return 'Consultant';
      case ProgressEventKind.reconsultation:
        return 'Reconsultation';
      case ProgressEventKind.therapySession:
        return 'Therapy Session';
    }
  }

  IconData get icon {
    switch (this) {
      case ProgressEventKind.reception:
        return Icons.person_outline_rounded;
      case ProgressEventKind.assistantManager:
        return Icons.badge_outlined;
      case ProgressEventKind.historyTaker:
        return Icons.description_outlined;
      case ProgressEventKind.consultant:
        return Icons.medical_services_outlined;
      case ProgressEventKind.reconsultation:
        return Icons.replay_rounded;
      case ProgressEventKind.therapySession:
        return Icons.favorite_border_rounded;
    }
  }

  Color get accent {
    switch (this) {
      case ProgressEventKind.reception:
        return AppColors.primary;
      case ProgressEventKind.assistantManager:
        return AppColors.info;
      case ProgressEventKind.historyTaker:
        return AppColors.warning;
      case ProgressEventKind.consultant:
        return AppColors.error;
      case ProgressEventKind.reconsultation:
        return AppColors.info;
      case ProgressEventKind.therapySession:
        return AppColors.primaryDark;
    }
  }

  Color get softBg {
    switch (this) {
      case ProgressEventKind.reception:
        return AppColors.primaryLight;
      case ProgressEventKind.assistantManager:
        return AppColors.infoSoft;
      case ProgressEventKind.historyTaker:
        return AppColors.warningSoft;
      case ProgressEventKind.consultant:
        return AppColors.errorSoft;
      case ProgressEventKind.reconsultation:
        return AppColors.infoSoft;
      case ProgressEventKind.therapySession:
        return AppColors.primaryLight;
    }
  }
}
