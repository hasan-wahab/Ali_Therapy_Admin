import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_progress_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_day_block.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_event_kind.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_status_chip.dart';

// ============================================================
// PATIENT DETAIL PROGRESS MAPPER
// ------------------------------------------------------------
// Maps Full View patient_progress[] → Progress tab widgets.
// ============================================================

class PatientDetailProgressMapper {
  PatientDetailProgressMapper._();

  static String visitTitle(PatientDetailProgressVisitEntity visit) {
    if (visit.visitNumber > 0) return 'Visit #${visit.visitNumber}';
    final id = PatientDetailDisplay.hashedId(visit.visitId);
    if (id == PatientDetailDisplay.empty) return 'Visit ${PatientDetailDisplay.empty}';
    return 'Visit $id';
  }

  static ProgressEventStatus status(String raw) {
    final value = raw.trim().toLowerCase().replaceAll('-', '_');
    if (value == 'in_progress' ||
        value == 'in progress' ||
        value == 'pending') {
      return ProgressEventStatus.inProgress;
    }
    return ProgressEventStatus.completed;
  }

  static ProgressEventKind kind(String raw) {
    final value = raw.trim().toLowerCase().replaceAll('-', '_');
    switch (value) {
      case 'reception':
        return ProgressEventKind.reception;
      case 'assistant':
      case 'assistant_manager':
      case 'assistantmanager':
        return ProgressEventKind.assistantManager;
      case 'history':
      case 'history_taker':
      case 'historytaker':
        return ProgressEventKind.historyTaker;
      case 'consultant':
        return ProgressEventKind.consultant;
      case 'reconsultation':
      case 'reconsult':
        return ProgressEventKind.reconsultation;
      case 'therapy':
      case 'therapy_session':
      case 'therapysession':
      case 'session':
        return ProgressEventKind.therapySession;
      default:
        return ProgressEventKind.reception;
    }
  }

  static ProgressDayEventData event(PatientDetailProgressEventEntity item) {
    final eventKind = kind(item.kind);
    final eventStatus = item.status.trim().isEmpty ||
            item.status == PatientDetailDisplay.empty
        ? null
        : status(item.status);
    final packageLine = PatientDetailDisplay.text(item.packageLine);
    final startTime = PatientDetailDisplay.time(item.startTime);
    final endTime = PatientDetailDisplay.time(item.endTime);
    final duration = PatientDetailDisplay.text(item.duration);
    final hasSessionMeta = packageLine != PatientDetailDisplay.empty &&
        startTime != PatientDetailDisplay.empty &&
        endTime != PatientDetailDisplay.empty &&
        duration != PatientDetailDisplay.empty;

    return ProgressDayEventData(
      kind: eventKind,
      timeLabel: PatientDetailDisplay.time(item.time),
      staffName: PatientDetailDisplay.text(item.staffName),
      status: eventStatus,
      highlightBorder: eventKind == ProgressEventKind.reconsultation &&
          eventStatus == ProgressEventStatus.inProgress,
      packageLine: hasSessionMeta ? packageLine : null,
      startTime: hasSessionMeta ? startTime : null,
      endTime: hasSessionMeta ? endTime : null,
      duration: hasSessionMeta ? duration : null,
    );
  }
}
