import 'package:equatable/equatable.dart';

import 'consultation_report_entity.dart';

// ============================================================
// CONSULTATION REPORT CLINIC COUNTS (Domain)
// ------------------------------------------------------------
// One clinic bucket under Show Stats.
// ============================================================

class ConsultationReportClinicCountEntity extends Equatable {
  const ConsultationReportClinicCountEntity({
    required this.name,
    required this.consultations,
  });

  final String name;
  final int consultations;

  @override
  List<Object?> get props => [name, consultations];
}

// ============================================================
// CONSULTATION REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the consultation report.
// ============================================================

class ConsultationReportSummaryEntity extends Equatable {
  const ConsultationReportSummaryEntity({
    required this.totalConsultations,
    this.clinics = const [],
  });

  const ConsultationReportSummaryEntity.empty()
      : totalConsultations = 0,
        clinics = const [];

  final int totalConsultations;
  final List<ConsultationReportClinicCountEntity> clinics;

  bool get isEmpty => totalConsultations == 0 && clinics.isEmpty;

  /// Fallback when the API does not send a totals object.
  /// [clinicNames] keeps every clinic in the filter list, even at 0.
  factory ConsultationReportSummaryEntity.fromRows(
    List<ConsultationReportEntity> rows, {
    int? consultationCount,
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

    return ConsultationReportSummaryEntity(
      totalConsultations: consultationCount ?? rows.length,
      clinics: [
        for (final name in order)
          ConsultationReportClinicCountEntity(
            name: name,
            consultations: counts[name] ?? 0,
          ),
      ],
    );
  }

  @override
  List<Object?> get props => [totalConsultations, clinics];
}
