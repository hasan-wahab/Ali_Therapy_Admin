import '../../../domain/patient_report_domain/entities/patient_report_entity.dart';
import '../../../domain/patient_report_domain/entities/patient_report_page_entity.dart';

// ============================================================
// PATIENT REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/patient-report
// ============================================================

class PatientReportModel extends PatientReportEntity {
  const PatientReportModel({
    required super.id,
    required super.patientName,
    required super.email,
    required super.visitsCount,
    required super.createdAt,
    required super.createdBy,
  });

  factory PatientReportModel.fromJson(Map<String, dynamic> json) {
    return PatientReportModel(
      id: json['id']?.toString() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      email: json['email']?.toString().trim() ?? '',
      visitsCount: _toInt(json['visits_count']),
      createdAt: json['created_at']?.toString().trim() ?? '',
      createdBy: json['created_by']?.toString().trim() ?? '',
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static List<PatientReportModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map((e) => PatientReportModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  PatientReportEntity toEntity() => PatientReportEntity(
        id: id,
        patientName: patientName,
        email: email,
        visitsCount: visitsCount,
        createdAt: createdAt,
        createdBy: createdBy,
      );
}

// ============================================================
// PATIENT REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class PatientReportPageModel extends PatientReportPageEntity {
  const PatientReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory PatientReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? PatientReportModel.listFromJson(list)
        : <PatientReportModel>[];

    return PatientReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  PatientReportPageEntity toEntity() => PatientReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
