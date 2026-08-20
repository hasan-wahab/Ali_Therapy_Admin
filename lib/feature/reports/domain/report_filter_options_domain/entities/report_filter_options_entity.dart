import 'package:equatable/equatable.dart';

import 'report_clinic_option_entity.dart';
import 'report_person_option_entity.dart';

// ============================================================
// REPORT FILTER OPTIONS ENTITY (Domain)
// ------------------------------------------------------------
// All dropdown lists for report screens.
// Comes from GET /api/admin/reports/filter-options
// ============================================================

class ReportFilterOptionsEntity extends Equatable {
  const ReportFilterOptionsEntity({
    required this.clinics,
    required this.consultants,
    required this.therapists,
    required this.receptionists,
    required this.assistantManagers,
    required this.insurancePanels,
  });

  const ReportFilterOptionsEntity.empty()
      : clinics = const [],
        consultants = const [],
        therapists = const [],
        receptionists = const [],
        assistantManagers = const [],
        insurancePanels = const [];

  final List<ReportClinicOptionEntity> clinics;
  final List<ReportPersonOptionEntity> consultants;
  final List<ReportPersonOptionEntity> therapists;
  final List<ReportPersonOptionEntity> receptionists;
  final List<ReportPersonOptionEntity> assistantManagers;

  // Insurance panels share the same id/name shape as clinics.
  final List<ReportClinicOptionEntity> insurancePanels;

  @override
  List<Object?> get props => [
        clinics,
        consultants,
        therapists,
        receptionists,
        assistantManagers,
        insurancePanels,
      ];
}
