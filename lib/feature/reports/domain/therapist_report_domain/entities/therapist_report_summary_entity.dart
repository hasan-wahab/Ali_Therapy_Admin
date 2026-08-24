import 'package:equatable/equatable.dart';

import 'therapist_report_entity.dart';

// ============================================================
// THERAPIST REPORT CLINIC COUNTS (Domain)
// ------------------------------------------------------------
// One clinic bucket under Show Stats.
// ============================================================

class TherapistReportClinicCountEntity extends Equatable {
  const TherapistReportClinicCountEntity({
    required this.name,
    required this.sessions,
  });

  final String name;
  final int sessions;

  @override
  List<Object?> get props => [name, sessions];
}

// ============================================================
// THERAPIST REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the therapist report.
// ============================================================

class TherapistReportSummaryEntity extends Equatable {
  const TherapistReportSummaryEntity({
    required this.totalSessions,
    this.clinics = const [],
  });

  const TherapistReportSummaryEntity.empty()
      : totalSessions = 0,
        clinics = const [];

  final int totalSessions;
  final List<TherapistReportClinicCountEntity> clinics;

  bool get isEmpty => totalSessions == 0 && clinics.isEmpty;

  /// Fallback when the API does not send a totals object.
  /// [clinicNames] keeps every clinic in the filter list, even at 0.
  factory TherapistReportSummaryEntity.fromRows(
    List<TherapistReportEntity> rows, {
    int? sessionCount,
    List<String> clinicNames = const [],
  }) {
    final counts = <String, int>{};
    final order = <String>[];

    void addName(String raw) {
      final name = raw.trim();
      if (name.isEmpty) return;
      if (counts.containsKey(name)) return;
      order.add(name);
      counts[name] = 0;
    }

    for (final name in clinicNames) {
      addName(name);
    }
    for (final row in rows) {
      addName(row.clinicName);
      final name = row.clinicName.trim();
      if (name.isEmpty) continue;
      counts[name] = (counts[name] ?? 0) + 1;
    }

    return TherapistReportSummaryEntity(
      totalSessions: sessionCount ?? rows.length,
      clinics: [
        for (final name in order)
          TherapistReportClinicCountEntity(
            name: name,
            sessions: counts[name] ?? 0,
          ),
      ],
    );
  }

  @override
  List<Object?> get props => [totalSessions, clinics];
}
