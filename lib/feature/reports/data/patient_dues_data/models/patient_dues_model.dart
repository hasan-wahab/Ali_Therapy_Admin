import '../../../domain/patient_dues_domain/entities/patient_dues_entity.dart';
import '../../../domain/patient_dues_domain/entities/patient_dues_page_entity.dart';

// ============================================================
// PATIENT DUES MODEL (Data)
// ------------------------------------------------------------
// Parses one row from /api/admin/reports/patient-dues
// ============================================================

class PatientDuesModel extends PatientDuesEntity {
  const PatientDuesModel({
    required super.id,
    required super.patientName,
    required super.patientCnic,
    required super.patientPhone,
    required super.receptionistName,
    required super.consultationBilled,
    required super.packageBilled,
    required super.grossBilled,
    required super.directDiscount,
    required super.insuranceDiscount,
    required super.totalDiscount,
    required super.totalPaid,
    required super.totalDue,
  });

  factory PatientDuesModel.fromJson(Map<String, dynamic> json) {
    return PatientDuesModel(
      id: json['id']?.toString() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      receptionistName: json['receptionist_name']?.toString().trim() ?? '',
      consultationBilled: _toDouble(json['consultation_billed']),
      packageBilled: _toDouble(json['package_billed']),
      grossBilled: _toDouble(json['gross_billed']),
      directDiscount: _toDouble(json['direct_discount']),
      insuranceDiscount: _toDouble(json['insurance_discount']),
      totalDiscount: _toDouble(json['total_discount']),
      totalPaid: _toDouble(json['total_paid']),
      totalDue: _toDouble(json['total_due']),
    );
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0;
  }

  static List<PatientDuesModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map((e) => PatientDuesModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  PatientDuesEntity toEntity() => PatientDuesEntity(
        id: id,
        patientName: patientName,
        patientCnic: patientCnic,
        patientPhone: patientPhone,
        receptionistName: receptionistName,
        consultationBilled: consultationBilled,
        packageBilled: packageBilled,
        grossBilled: grossBilled,
        directDiscount: directDiscount,
        insuranceDiscount: insuranceDiscount,
        totalDiscount: totalDiscount,
        totalPaid: totalPaid,
        totalDue: totalDue,
      );
}

// ============================================================
// PATIENT DUES PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class PatientDuesPageModel extends PatientDuesPageEntity {
  const PatientDuesPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory PatientDuesPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List ? PatientDuesModel.listFromJson(list) : <PatientDuesModel>[];
    return PatientDuesPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  PatientDuesPageEntity toEntity() => PatientDuesPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
