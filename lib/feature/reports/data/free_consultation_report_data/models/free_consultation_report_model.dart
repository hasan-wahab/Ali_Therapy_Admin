import '../../../domain/free_consultation_report_domain/entities/free_consultation_report_entity.dart';
import '../../../domain/free_consultation_report_domain/entities/free_consultation_report_page_entity.dart';

// ============================================================
// FREE CONSULTATION REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/free-consultation
// ============================================================

class FreeConsultationReportModel extends FreeConsultationReportEntity {
  const FreeConsultationReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.consultantName,
    required super.clinicName,
    required super.fee,
  });

  factory FreeConsultationReportModel.fromJson(Map<String, dynamic> json) {
    return FreeConsultationReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      consultantName: json['consultant_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      fee: _toDouble(json['fee']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static List<FreeConsultationReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => FreeConsultationReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  FreeConsultationReportEntity toEntity() => FreeConsultationReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        consultantName: consultantName,
        clinicName: clinicName,
        fee: fee,
      );
}

// ============================================================
// FREE CONSULTATION REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class FreeConsultationReportPageModel extends FreeConsultationReportPageEntity {
  const FreeConsultationReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory FreeConsultationReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? FreeConsultationReportModel.listFromJson(list)
        : <FreeConsultationReportModel>[];

    return FreeConsultationReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  FreeConsultationReportPageEntity toEntity() =>
      FreeConsultationReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
