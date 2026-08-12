import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_day_block.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_event_kind.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/progress_status_chip.dart';

// ============================================================
// PROGRESS VISIT SAMPLES
// ------------------------------------------------------------
// Sample visit timeline data for Progress tab (UI only).
//
// Flow:
//   #1              → Consultation (full stages)
//   #2–5, #7–10     → Reception → Therapy Session
//   #6, #11         → Reception → Assistant → Reconsultation → Therapy
// ============================================================

class ProgressVisitSample {
  const ProgressVisitSample({
    required this.visitNumber,
    required this.dateTime,
    required this.visitType,
    required this.events,
    this.status = ProgressEventStatus.completed,
  });

  final int visitNumber;
  final String dateTime;
  final String visitType;
  final ProgressEventStatus status;
  final List<ProgressDayEventData> events;

  String get visitTitle => 'Visit #$visitNumber';
}

class ProgressVisitSamples {
  ProgressVisitSamples._();

  static List<ProgressVisitSample> get all => [
        _consultationVisit(),
        for (var n = 2; n <= 11; n++)
          _isReconsultationVisit(n)
              ? _reconsultationVisit(n)
              : _packageSessionVisit(n),
      ];

  /// Reconsultation visits: 6, 11, 16, ...
  static bool _isReconsultationVisit(int visitNumber) {
    return visitNumber > 1 && (visitNumber - 1) % 5 == 0;
  }

  static ProgressVisitSample _consultationVisit() {
    return const ProgressVisitSample(
      visitNumber: 1,
      dateTime: 'Aug 01, 2026 at 01:38 PM',
      visitType: 'CONSULTATION',
      events: [
        ProgressDayEventData(
          kind: ProgressEventKind.reception,
          timeLabel: '01:38 PM',
          staffName: 'KAINAT RASHEED',
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.assistantManager,
          timeLabel: '01:39 PM',
          staffName: 'DR ALIHA BATOOL',
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.historyTaker,
          timeLabel: '01:52 PM',
          staffName: 'DR ALIHA BATOOL',
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.consultant,
          timeLabel: '02:00 PM',
          staffName: 'DR BILAL AHMED Clinic 1',
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.therapySession,
          timeLabel: 'Aug 01, 2026 02:42 PM',
          staffName: 'DR ISLAM BIBI',
          packageLine: 'Session 1 of 30 (30 days session package)',
          startTime: '02:07 PM',
          endTime: '02:42 PM',
          duration: '00:35:02',
        ),
      ],
    );
  }

  static ProgressVisitSample _packageSessionVisit(int visitNumber) {
    final meta = _sessionMeta(visitNumber);
    return ProgressVisitSample(
      visitNumber: visitNumber,
      dateTime: meta.dateTime,
      visitType: 'PACKAGE_SESSION',
      events: [
        ProgressDayEventData(
          kind: ProgressEventKind.reception,
          timeLabel: meta.receptionTime,
          staffName: 'KAINAT RASHEED',
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.therapySession,
          timeLabel: meta.therapyTime,
          staffName: 'DR ISLAM BIBI',
          packageLine:
              'Session $visitNumber of 30 (30 days session package)',
          startTime: meta.startTime,
          endTime: meta.endTime,
          duration: meta.duration,
        ),
      ],
    );
  }

  static ProgressVisitSample _reconsultationVisit(int visitNumber) {
    final meta = _sessionMeta(visitNumber);
    return ProgressVisitSample(
      visitNumber: visitNumber,
      dateTime: meta.dateTime,
      visitType: 'PACKAGE_SESSION',
      events: [
        ProgressDayEventData(
          kind: ProgressEventKind.reception,
          timeLabel: meta.receptionTime,
          staffName: 'KAINAT RASHEED',
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.assistantManager,
          timeLabel: meta.assistantTime,
          staffName: 'DR ALIHA BATOOL',
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.reconsultation,
          timeLabel: meta.reconsultTime,
          staffName: 'DR BILAL AHMED Clinic 1',
          status: ProgressEventStatus.inProgress,
          highlightBorder: true,
        ),
        ProgressDayEventData(
          kind: ProgressEventKind.therapySession,
          timeLabel: meta.therapyTime,
          staffName: 'DR ISLAM BIBI',
          packageLine:
              'Session $visitNumber of 30 (30 days session package)',
          startTime: meta.startTime,
          endTime: meta.endTime,
          duration: meta.duration,
        ),
      ],
    );
  }

  static _SessionMeta _sessionMeta(int visitNumber) {
    // Sample timestamps aligned with provided UI screenshots where known.
    switch (visitNumber) {
      case 2:
        return const _SessionMeta(
          dateTime: 'Aug 03, 2026 at 08:37 AM',
          receptionTime: 'Aug 03, 2026 08:37 AM',
          assistantTime: 'Aug 03, 2026 08:40 AM',
          reconsultTime: 'Aug 03, 2026 08:42 AM',
          therapyTime: 'Aug 03, 2026 09:18 AM',
          startTime: '08:41 AM',
          endTime: '09:18 AM',
          duration: '00:36:54',
        );
      case 6:
        return const _SessionMeta(
          dateTime: 'Aug 04, 2026 at 12:56 PM',
          receptionTime: 'Aug 04, 2026 12:56 PM',
          assistantTime: 'Aug 04, 2026 12:58 PM',
          reconsultTime: 'Aug 04, 2026 12:57 PM',
          therapyTime: 'Aug 04, 2026 01:40 PM',
          startTime: '12:59 PM',
          endTime: '01:41 PM',
          duration: '00:42:09',
        );
      case 11:
        return const _SessionMeta(
          dateTime: 'Aug 10, 2026 at 10:15 AM',
          receptionTime: 'Aug 10, 2026 10:15 AM',
          assistantTime: 'Aug 10, 2026 10:18 AM',
          reconsultTime: 'Aug 10, 2026 10:20 AM',
          therapyTime: 'Aug 10, 2026 11:00 AM',
          startTime: '10:25 AM',
          endTime: '11:00 AM',
          duration: '00:35:00',
        );
      default:
        final day = visitNumber + 1;
        return _SessionMeta(
          dateTime: 'Aug ${day.toString().padLeft(2, '0')}, 2026 at 09:00 AM',
          receptionTime: 'Aug ${day.toString().padLeft(2, '0')}, 2026 09:00 AM',
          assistantTime: 'Aug ${day.toString().padLeft(2, '0')}, 2026 09:05 AM',
          reconsultTime: 'Aug ${day.toString().padLeft(2, '0')}, 2026 09:10 AM',
          therapyTime: 'Aug ${day.toString().padLeft(2, '0')}, 2026 09:45 AM',
          startTime: '09:10 AM',
          endTime: '09:45 AM',
          duration: '00:35:00',
        );
    }
  }
}

class _SessionMeta {
  const _SessionMeta({
    required this.dateTime,
    required this.receptionTime,
    required this.assistantTime,
    required this.reconsultTime,
    required this.therapyTime,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  final String dateTime;
  final String receptionTime;
  final String assistantTime;
  final String reconsultTime;
  final String therapyTime;
  final String startTime;
  final String endTime;
  final String duration;
}
