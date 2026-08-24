import 'package:equatable/equatable.dart';

import 'reconsultation_report_entity.dart';

// ============================================================
// RECONSULTATION REPORT CLINIC COUNTS (Domain)
// ------------------------------------------------------------
// One clinic bucket under Show Stats.
// ============================================================

class ReconsultationReportClinicCountEntity extends Equatable {
  const ReconsultationReportClinicCountEntity({
    required this.name,
    required this.reconsultations,
  });

  final String name;
  final int reconsultations;

  @override
  List<Object?> get props => [name, reconsultations];
}

// ============================================================
// RECONSULTATION REPORT SUMMARY (Domain)
// ------------------------------------------------------------
// Totals shown under Show Stats on the reconsultation report.
// ============================================================

class ReconsultationReportSummaryEntity extends Equatable {
  const ReconsultationReportSummaryEntity({
    required this.totalReconsultations,
    this.clinics = const [],
  });

  const ReconsultationReportSummaryEntity.empty()
      : totalReconsultations = 0,
        clinics = const [];

  final int totalReconsultations;
  final List<ReconsultationReportClinicCountEntity> clinics;

  bool get isEmpty => totalReconsultations == 0 && clinics.isEmpty;

  /// Fallback when the API does not send a totals object.
  /// [clinicNames] keeps every clinic in the filter list, even at 0.
  factory ReconsultationReportSummaryEntity.fromRows(
    List<ReconsultationReportEntity> rows, {
    int? reconsultationCount,
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

    return ReconsultationReportSummaryEntity(
      totalReconsultations: reconsultationCount ?? rows.length,
      clinics: [
        for (final name in order)
          ReconsultationReportClinicCountEntity(
            name: name,
            reconsultations: counts[name] ?? 0,
          ),
      ],
    );
  }

  @override
  List<Object?> get props => [totalReconsultations, clinics];
}
