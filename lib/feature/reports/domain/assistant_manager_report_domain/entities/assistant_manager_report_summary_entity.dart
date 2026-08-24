import 'package:equatable/equatable.dart';

import 'assistant_manager_report_entity.dart';

// ============================================================
// ASSISTANT MANAGER REPORT CLINIC VISITS (Domain)
// ------------------------------------------------------------
// One clinic bucket under Show Stats.
// ============================================================

class AssistantManagerReportClinicVisitEntity extends Equatable {
  const AssistantManagerReportClinicVisitEntity({
    required this.name,
    required this.visits,
  });

  final String name;
  final int visits;

  @override
  List<Object?> get props => [name, visits];
}

// ============================================================
// ASSISTANT MANAGER REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the assistant manager report.
// ============================================================

class AssistantManagerReportSummaryEntity extends Equatable {
  const AssistantManagerReportSummaryEntity({
    required this.totalVisits,
    this.clinics = const [],
  });

  const AssistantManagerReportSummaryEntity.empty()
      : totalVisits = 0,
        clinics = const [];

  final int totalVisits;
  final List<AssistantManagerReportClinicVisitEntity> clinics;

  bool get isEmpty => totalVisits == 0 && clinics.isEmpty;

  /// Fallback when the API does not send a totals object.
  /// [clinicNames] keeps every clinic in the filter list, even at 0 visits.
  factory AssistantManagerReportSummaryEntity.fromRows(
    List<AssistantManagerReportEntity> rows, {
    int? visitCount,
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

    return AssistantManagerReportSummaryEntity(
      totalVisits: visitCount ?? rows.length,
      clinics: [
        for (final name in order)
          AssistantManagerReportClinicVisitEntity(
            name: name,
            visits: counts[name] ?? 0,
          ),
      ],
    );
  }

  @override
  List<Object?> get props => [totalVisits, clinics];
}
