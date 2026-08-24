import 'package:equatable/equatable.dart';

import 'receptionist_report_entity.dart';

// ============================================================
// RECEPTIONIST REPORT CLINIC VISITS (Domain)
// ------------------------------------------------------------
// One clinic bucket under Show Stats.
// ============================================================

class ReceptionistReportClinicVisitEntity extends Equatable {
  const ReceptionistReportClinicVisitEntity({
    required this.name,
    required this.visits,
  });

  final String name;
  final int visits;

  @override
  List<Object?> get props => [name, visits];
}

// ============================================================
// RECEPTIONIST REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the receptionist report.
// ============================================================

class ReceptionistReportSummaryEntity extends Equatable {
  const ReceptionistReportSummaryEntity({
    required this.totalVisits,
    this.clinics = const [],
  });

  const ReceptionistReportSummaryEntity.empty()
      : totalVisits = 0,
        clinics = const [];

  final int totalVisits;
  final List<ReceptionistReportClinicVisitEntity> clinics;

  bool get isEmpty => totalVisits == 0 && clinics.isEmpty;

  /// Fallback when the API does not send a totals object.
  /// [clinicNames] keeps every clinic in the filter list, even at 0 visits.
  factory ReceptionistReportSummaryEntity.fromRows(
    List<ReceptionistReportEntity> rows, {
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

    return ReceptionistReportSummaryEntity(
      totalVisits: visitCount ?? rows.length,
      clinics: [
        for (final name in order)
          ReceptionistReportClinicVisitEntity(
            name: name,
            visits: counts[name] ?? 0,
          ),
      ],
    );
  }

  @override
  List<Object?> get props => [totalVisits, clinics];
}
