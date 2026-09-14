// ============================================================
// RECONSULTATION HISTORY ITEM
// ------------------------------------------------------------
// One list row for the UI-first Reconsultation History screen.
// ============================================================

class ReconsultationHistoryItem {
  const ReconsultationHistoryItem({
    required this.date,
    required this.time,
    required this.consultant,
    required this.clinic,
    required this.recoveryScore,
    required this.complaint,
  });

  final String date;
  final String time;
  final String consultant;
  final String clinic;
  final String recoveryScore;
  final String complaint;
}

/// Sample rows until the API is wired.
const List<ReconsultationHistoryItem> reconsultationHistorySample = [
  ReconsultationHistoryItem(
    date: 'September 02, 2026',
    time: '06:00 PM',
    consultant: 'DR BILAL AHMED',
    clinic: 'Clinic 1',
    recoveryScore: '5%',
    complaint: 'No complaints reported',
  ),
  ReconsultationHistoryItem(
    date: 'July 16, 2026',
    time: '11:30 PM',
    consultant: 'DR BILAL AHMED',
    clinic: 'Clinic 1',
    recoveryScore: '6%',
    complaint: 'No complaints reported',
  ),
];
