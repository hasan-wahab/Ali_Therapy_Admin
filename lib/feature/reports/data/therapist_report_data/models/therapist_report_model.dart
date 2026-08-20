import '../../../domain/therapist_report_domain/entities/therapist_report_entity.dart';
import '../../../domain/therapist_report_domain/entities/therapist_report_page_entity.dart';

// ============================================================
// THERAPIST REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/therapist
// ============================================================

class TherapistReportModel extends TherapistReportEntity {
  const TherapistReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.therapistName,
    required super.consultantName,
    required super.clinicName,
    required super.status,
  });

  factory TherapistReportModel.fromJson(Map<String, dynamic> json) {
    return TherapistReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      therapistName: json['therapist_name']?.toString().trim() ?? '',
      consultantName: json['consultant_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      status: json['status']?.toString().trim() ?? '',
    );
  }

  static List<TherapistReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => TherapistReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  TherapistReportEntity toEntity() => TherapistReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        therapistName: therapistName,
        consultantName: consultantName,
        clinicName: clinicName,
        status: status,
      );
}

// ============================================================
// THERAPIST REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class TherapistReportPageModel extends TherapistReportPageEntity {
  const TherapistReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory TherapistReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? TherapistReportModel.listFromJson(list)
        : <TherapistReportModel>[];

    return TherapistReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  TherapistReportPageEntity toEntity() => TherapistReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
