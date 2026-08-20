import '../../../domain/patient_dues_history_domain/entities/patient_dues_history_entity.dart';

// ============================================================
// PATIENT DUES HISTORY MODEL (Data)
// ------------------------------------------------------------
// Parses one invoice from GET /api/admin/reports/patient-dues/{id}
// ============================================================

class PatientDuesHistoryModel extends PatientDuesHistoryEntity {
  const PatientDuesHistoryModel({
    required super.invoiceNumber,
    required super.date,
    required super.type,
    required super.billedAmount,
    required super.discount,
    required super.insurance,
    required super.paid,
    required super.due,
  });

  factory PatientDuesHistoryModel.fromJson(Map<String, dynamic> json) {
    return PatientDuesHistoryModel(
      invoiceNumber: json['invoice_number']?.toString() ?? '',
      date: json['date']?.toString().trim() ?? '',
      type: json['type']?.toString().trim() ?? '',
      billedAmount: _toDouble(json['billed_amount']),
      discount: _toDouble(json['discount']),
      insurance: _toDouble(json['insurance']),
      paid: _toDouble(json['paid']),
      due: _toDouble(json['due']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static List<PatientDuesHistoryModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map(
            (e) => PatientDuesHistoryModel.fromJson(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList();

  PatientDuesHistoryEntity toEntity() => PatientDuesHistoryEntity(
        invoiceNumber: invoiceNumber,
        date: date,
        type: type,
        billedAmount: billedAmount,
        discount: discount,
        insurance: insurance,
        paid: paid,
        due: due,
      );
}
