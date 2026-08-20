import '../../../domain/report_filter_options_domain/entities/report_clinic_option_entity.dart';

// ============================================================
// REPORT CLINIC OPTION MODEL (Data)
// ------------------------------------------------------------
// Parses: { "id": 72, "name": "Clinic 1" }
// Also used for insurance_panels (same shape).
// ============================================================

class ReportClinicOptionModel extends ReportClinicOptionEntity {
  const ReportClinicOptionModel({required super.id, required super.name});

  factory ReportClinicOptionModel.fromJson(Map<String, dynamic> json) {
    return ReportClinicOptionModel(
      id: (json['id'] as num).toInt(),
      name: json['name']?.toString().trim() ?? '',
    );
  }

  static List<ReportClinicOptionModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => ReportClinicOptionModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();
}
