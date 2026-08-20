import '../../../domain/report_filter_options_domain/entities/report_filter_options_entity.dart';
import 'report_clinic_option_model.dart';
import 'report_person_option_model.dart';

// ============================================================
// REPORT FILTER OPTIONS MODEL (Data)
// ------------------------------------------------------------
// Parses GET /api/admin/reports/filter-options response:
// { "success": true, "data": { "clinics": [...], ... } }
// ============================================================

class ReportFilterOptionsModel extends ReportFilterOptionsEntity {
  const ReportFilterOptionsModel({
    required super.clinics,
    required super.consultants,
    required super.therapists,
    required super.receptionists,
    required super.assistantManagers,
    required super.insurancePanels,
  });

  /// Parse the full API response envelope.
  factory ReportFilterOptionsModel.fromResponse(
    Map<String, dynamic> response,
  ) {
    // Unwrap "data" if present, otherwise use root.
    final raw = response['data'] is Map
        ? Map<String, dynamic>.from(response['data'] as Map)
        : response;

    return ReportFilterOptionsModel(
      clinics: ReportClinicOptionModel.listFromJson(
        raw['clinics'] as List? ?? [],
      ),
      consultants: ReportPersonOptionModel.listFromJson(
        raw['consultants'] as List? ?? [],
      ),
      therapists: ReportPersonOptionModel.listFromJson(
        raw['therapists'] as List? ?? [],
      ),
      receptionists: ReportPersonOptionModel.listFromJson(
        raw['receptionists'] as List? ?? [],
      ),
      assistantManagers: ReportPersonOptionModel.listFromJson(
        raw['assistant_managers'] as List? ?? [],
      ),
      insurancePanels: ReportClinicOptionModel.listFromJson(
        raw['insurance_panels'] as List? ?? [],
      ),
    );
  }

  ReportFilterOptionsEntity toEntity() => ReportFilterOptionsEntity(
        clinics: clinics,
        consultants: consultants,
        therapists: therapists,
        receptionists: receptionists,
        assistantManagers: assistantManagers,
        insurancePanels: insurancePanels,
      );
}
