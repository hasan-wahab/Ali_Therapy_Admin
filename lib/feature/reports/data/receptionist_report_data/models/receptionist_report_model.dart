import '../../../domain/receptionist_report_domain/entities/receptionist_report_entity.dart';
import '../../../domain/receptionist_report_domain/entities/receptionist_report_page_entity.dart';

// ============================================================
// RECEPTIONIST REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/receptionist
// ============================================================

class ReceptionistReportModel extends ReceptionistReportEntity {
  const ReceptionistReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.receptionistName,
    required super.clinicName,
    required super.amountCollected,
  });

  factory ReceptionistReportModel.fromJson(Map<String, dynamic> json) {
    return ReceptionistReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      receptionistName: json['receptionist_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      amountCollected: _toDouble(json['amount_collected']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static List<ReceptionistReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => ReceptionistReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  ReceptionistReportEntity toEntity() => ReceptionistReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        receptionistName: receptionistName,
        clinicName: clinicName,
        amountCollected: amountCollected,
      );
}

// ============================================================
// RECEPTIONIST REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class ReceptionistReportPageModel extends ReceptionistReportPageEntity {
  const ReceptionistReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory ReceptionistReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? ReceptionistReportModel.listFromJson(list)
        : <ReceptionistReportModel>[];

    return ReceptionistReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  ReceptionistReportPageEntity toEntity() => ReceptionistReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
