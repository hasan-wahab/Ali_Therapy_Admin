import 'package:equatable/equatable.dart';

import 'in_progress_sessions_entity.dart';
import 'in_progress_sessions_query.dart';

// ============================================================
// IN-PROGRESS SESSIONS SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the in-progress sessions
// report.
// ============================================================

class InProgressSessionsSummaryEntity extends Equatable {
  const InProgressSessionsSummaryEntity({
    required this.totalInProgress,
    required this.consultationsActive,
    required this.therapyActive,
    required this.clinicsActive,
  });

  const InProgressSessionsSummaryEntity.empty()
      : totalInProgress = 0,
        consultationsActive = 0,
        therapyActive = 0,
        clinicsActive = 0;

  final int totalInProgress;
  final int consultationsActive;
  final int therapyActive;
  final int clinicsActive;

  bool get isEmpty =>
      totalInProgress == 0 &&
      consultationsActive == 0 &&
      therapyActive == 0 &&
      clinicsActive == 0;

  /// Fallback when the API does not send a totals object.
  factory InProgressSessionsSummaryEntity.fromRows(
    List<InProgressSessionsEntity> rows, {
    int? sessionCount,
  }) {
    var consultations = 0;
    var therapy = 0;
    final clinics = <String>{};

    for (final row in rows) {
      if (_isConsultation(row)) consultations++;
      if (_isTherapy(row)) therapy++;
      final clinic = row.clinicName.trim();
      if (clinic.isNotEmpty && clinic != '_') clinics.add(clinic);
    }

    return InProgressSessionsSummaryEntity(
      totalInProgress: sessionCount ?? rows.length,
      consultationsActive: consultations,
      therapyActive: therapy,
      clinicsActive: clinics.length,
    );
  }

  static bool _isConsultation(InProgressSessionsEntity row) {
    if (row.sessionTypes.isNotEmpty) {
      for (final type in row.sessionTypes) {
        final lower = type.toLowerCase();
        if (lower.contains('consult') ||
            lower.contains(InProgressSessionsQuery.sessionTypeConsultant)) {
          return true;
        }
      }
      return false;
    }
    return row.consultantName.trim().isNotEmpty &&
        row.consultantName.trim() != '_' &&
        (row.therapistName.trim().isEmpty || row.therapistName.trim() == '_');
  }

  static bool _isTherapy(InProgressSessionsEntity row) {
    if (row.sessionTypes.isNotEmpty) {
      for (final type in row.sessionTypes) {
        if (type.toLowerCase().contains('therap')) return true;
      }
      return false;
    }
    return row.therapistName.trim().isNotEmpty &&
        row.therapistName.trim() != '_';
  }

  @override
  List<Object?> get props => [
        totalInProgress,
        consultationsActive,
        therapyActive,
        clinicsActive,
      ];
}
