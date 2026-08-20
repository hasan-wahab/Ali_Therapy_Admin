import '../../../domain/report_filter_options_domain/entities/report_person_option_entity.dart';

// ============================================================
// REPORT PERSON OPTION MODEL (Data)
// ------------------------------------------------------------
// Parses:
// { "id": 684, "name": "Arsalan clinic1",
//   "profile_picture": "...", "detail": null }
// Used for consultants, therapists, receptionists,
// assistant_managers.
// ============================================================

class ReportPersonOptionModel extends ReportPersonOptionEntity {
  const ReportPersonOptionModel({
    required super.id,
    required super.name,
    super.profilePicture,
  });

  factory ReportPersonOptionModel.fromJson(Map<String, dynamic> json) {
    return ReportPersonOptionModel(
      id: (json['id'] as num).toInt(),
      name: json['name']?.toString().trim() ?? '',
      profilePicture: json['profile_picture']?.toString().trim(),
    );
  }

  static List<ReportPersonOptionModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => ReportPersonOptionModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();
}
