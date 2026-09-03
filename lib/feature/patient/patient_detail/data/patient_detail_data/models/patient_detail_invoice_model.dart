import '../../../domain/patient_detail_domain/entities/patient_detail_invoice_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL INVOICE MODEL
// ------------------------------------------------------------
// Parses one item from data.invoices
// ============================================================

class PatientDetailInvoicePaymentModel
    extends PatientDetailInvoicePaymentEntity {
  const PatientDetailInvoicePaymentModel({
    super.id,
    super.date,
    super.amount,
    super.method,
    super.type,
  });

  factory PatientDetailInvoicePaymentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PatientDetailInvoicePaymentModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      date: PatientDetailJsonHelpers.text(json['date']),
      amount: PatientDetailJsonHelpers.decimal(json['amount']),
      method: PatientDetailJsonHelpers.text(json['method']),
      type: PatientDetailJsonHelpers.text(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'method': method,
      'type': type,
    };
  }

  PatientDetailInvoicePaymentEntity toEntity() {
    return PatientDetailInvoicePaymentEntity(
      id: id,
      date: date,
      amount: amount,
      method: method,
      type: type,
    );
  }
}

class PatientDetailInvoiceModel extends PatientDetailInvoiceEntity {
  const PatientDetailInvoiceModel({
    super.id,
    super.type,
    super.date,
    super.amount,
    super.discount,
    super.paid,
    super.due,
    super.status,
    super.payments,
  });

  factory PatientDetailInvoiceModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailInvoiceModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      type: PatientDetailJsonHelpers.text(json['type']),
      date: PatientDetailJsonHelpers.text(json['date']),
      amount: PatientDetailJsonHelpers.decimal(json['amount']),
      discount: PatientDetailJsonHelpers.decimal(json['discount']),
      paid: PatientDetailJsonHelpers.decimal(json['paid']),
      due: PatientDetailJsonHelpers.decimal(json['due']),
      status: PatientDetailJsonHelpers.text(json['status']),
      payments: PatientDetailJsonHelpers.mapList(
        json['payments'],
        PatientDetailInvoicePaymentModel.fromJson,
      ),
    );
  }

  static List<PatientDetailInvoiceModel> listFromJson(dynamic raw) {
    return PatientDetailJsonHelpers.mapList(
      raw,
      PatientDetailInvoiceModel.fromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'date': date,
      'amount': amount,
      'discount': discount,
      'paid': paid,
      'due': due,
      'status': status,
      'payments': payments
          .map(
            (item) => item is PatientDetailInvoicePaymentModel
                ? item.toJson()
                : PatientDetailInvoicePaymentModel(
                    id: item.id,
                    date: item.date,
                    amount: item.amount,
                    method: item.method,
                    type: item.type,
                  ).toJson(),
          )
          .toList(),
    };
  }

  PatientDetailInvoiceEntity toEntity() {
    return PatientDetailInvoiceEntity(
      id: id,
      type: type,
      date: date,
      amount: amount,
      discount: discount,
      paid: paid,
      due: due,
      status: status,
      payments: payments
          .map(
            (item) => item is PatientDetailInvoicePaymentModel
                ? item.toEntity()
                : PatientDetailInvoicePaymentEntity(
                    id: item.id,
                    date: item.date,
                    amount: item.amount,
                    method: item.method,
                    type: item.type,
                  ),
          )
          .toList(),
    );
  }
}
