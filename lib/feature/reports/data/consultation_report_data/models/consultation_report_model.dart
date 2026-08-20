import '../../../domain/consultation_report_domain/entities/consultation_report_entity.dart';
import '../../../domain/consultation_report_domain/entities/consultation_report_page_entity.dart';

// ============================================================
// CONSULTATION REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/consultant
// ============================================================

class ConsultationReportModel extends ConsultationReportEntity {
  const ConsultationReportModel({
    required super.id,
    required super.visitDate,
    required super.consultantName,
    required super.receptionistName,
    required super.assistantManagerName,
    required super.therapistName,
    required super.reviewStatus,
    required super.reviewRating,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.clinicName,
    required super.referBy,
    required super.totalBilled,
    required super.paidAmount,
    required super.discountAmount,
    required super.insuranceDiscount,
    required super.remainingBalance,
    required super.sessionsTotal,
    required super.sessionsUsed,
    required super.sessionsRemaining,
    required super.packageStatus,
  });

  factory ConsultationReportModel.fromJson(Map<String, dynamic> json) {
    return ConsultationReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      consultantName: json['consultant_name']?.toString().trim() ?? '',
      receptionistName: json['receptionist_name']?.toString().trim() ?? '',
      assistantManagerName:
          json['assistant_manager_name']?.toString().trim() ?? '',
      therapistName: json['therapist_name']?.toString().trim() ?? '',
      reviewStatus: json['review_status']?.toString().trim() ?? '',
      reviewRating: json['review_rating']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      referBy: json['refer_by']?.toString().trim() ?? '',
      totalBilled: _toDouble(json['total_billed']),
      paidAmount: _toDouble(json['paid_amount']),
      discountAmount: _toDouble(json['discount_amount']),
      insuranceDiscount: _toDouble(json['insurance_discount']),
      remainingBalance: _toDouble(json['remaining_balance']),
      sessionsTotal: _toInt(json['sessions_total']),
      sessionsUsed: _toInt(json['sessions_used']),
      sessionsRemaining: _toInt(json['sessions_remaining']),
      packageStatus: json['package_status']?.toString().trim() ?? '',
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static List<ConsultationReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => ConsultationReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  ConsultationReportEntity toEntity() => ConsultationReportEntity(
        id: id,
        visitDate: visitDate,
        consultantName: consultantName,
        receptionistName: receptionistName,
        assistantManagerName: assistantManagerName,
        therapistName: therapistName,
        reviewStatus: reviewStatus,
        reviewRating: reviewRating,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        clinicName: clinicName,
        referBy: referBy,
        totalBilled: totalBilled,
        paidAmount: paidAmount,
        discountAmount: discountAmount,
        insuranceDiscount: insuranceDiscount,
        remainingBalance: remainingBalance,
        sessionsTotal: sessionsTotal,
        sessionsUsed: sessionsUsed,
        sessionsRemaining: sessionsRemaining,
        packageStatus: packageStatus,
      );
}

// ============================================================
// CONSULTATION REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class ConsultationReportPageModel extends ConsultationReportPageEntity {
  const ConsultationReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory ConsultationReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? ConsultationReportModel.listFromJson(list)
        : <ConsultationReportModel>[];

    return ConsultationReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  ConsultationReportPageEntity toEntity() => ConsultationReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
