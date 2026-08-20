import '../../../domain/refer_by_report_domain/entities/refer_by_report_entity.dart';

// ============================================================
// REFER BY REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/refer-by
// ============================================================

class ReferByReportModel extends ReferByReportEntity {
  const ReferByReportModel({
    required super.id,
    required super.referralSource,
    required super.referralType,
    required super.patientCount,
    required super.grossBilled,
    required super.consultation,
    required super.packageBilled,
    required super.directDiscount,
    required super.insuranceDiscount,
    required super.packagePaid,
    required super.totalReceived,
    required super.dues,
  });

  factory ReferByReportModel.fromJson(Map<String, dynamic> json) {
    return ReferByReportModel(
      id: json['id']?.toString() ?? '',
      referralSource: json['referral_source']?.toString().trim() ?? '',
      referralType: json['referral_type']?.toString().trim() ?? '',
      patientCount: _toInt(json['patient_count']),
      grossBilled: _toDouble(json['gross_billed']),
      consultation: _toDouble(json['consultation']),
      packageBilled: _toDouble(json['package_billed']),
      directDiscount: _toDouble(json['direct_discount']),
      insuranceDiscount: _toDouble(json['insurance_discount']),
      packagePaid: _toDouble(json['package_paid']),
      totalReceived: _toDouble(json['total_received']),
      dues: _toDouble(json['dues']),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static List<ReferByReportModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map((e) => ReferByReportModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  ReferByReportEntity toEntity() => ReferByReportEntity(
    id: id,
    referralSource: referralSource,
    referralType: referralType,
    patientCount: patientCount,
    grossBilled: grossBilled,
    consultation: consultation,
    packageBilled: packageBilled,
    directDiscount: directDiscount,
    insuranceDiscount: insuranceDiscount,
    packagePaid: packagePaid,
    totalReceived: totalReceived,
    dues: dues,
  );
}
