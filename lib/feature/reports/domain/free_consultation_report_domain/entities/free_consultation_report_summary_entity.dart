import 'package:equatable/equatable.dart';

import 'free_consultation_report_entity.dart';

// ============================================================
// FREE CONSULTATION REPORT CLINIC COUNTS (Domain)
// ------------------------------------------------------------
// One clinic bucket under Show Stats.
// ============================================================

class FreeConsultationReportClinicCountEntity extends Equatable {
  const FreeConsultationReportClinicCountEntity({
    required this.name,
    required this.freeConsultations,
  });

  final String name;
  final int freeConsultations;

  @override
  List<Object?> get props => [name, freeConsultations];
}

// ============================================================
// FREE CONSULTATION REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the free consultation report.
// ============================================================

class FreeConsultationReportSummaryEntity extends Equatable {
  const FreeConsultationReportSummaryEntity({
    required this.totalFreeConsultations,
    this.clinics = const [],
  });

  const FreeConsultationReportSummaryEntity.empty()
      : totalFreeConsultations = 0,
        clinics = const [];

  final int totalFreeConsultations;
  final List<FreeConsultationReportClinicCountEntity> clinics;

  bool get isEmpty => totalFreeConsultations == 0 && clinics.isEmpty;

  /// Fallback when the API does not send a totals object.
  /// [clinicNames] keeps every clinic in the filter list, even at 0.
  factory FreeConsultationReportSummaryEntity.fromRows(
    List<FreeConsultationReportEntity> rows, {
    int? freeConsultationCount,
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

    return FreeConsultationReportSummaryEntity(
      totalFreeConsultations: freeConsultationCount ?? rows.length,
      clinics: [
        for (final name in order)
          FreeConsultationReportClinicCountEntity(
            name: name,
            freeConsultations: counts[name] ?? 0,
          ),
      ],
    );
  }

  @override
  List<Object?> get props => [totalFreeConsultations, clinics];
}
