import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL INVOICE (Domain)
// ------------------------------------------------------------
// API: data.invoices[]
// ============================================================

class PatientDetailInvoicePaymentEntity extends Equatable {
  const PatientDetailInvoicePaymentEntity({
    this.id = '',
    this.date = '',
    this.amount = 0,
    this.method = '',
    this.type = '',
  });

  final String id;
  final String date;
  final double amount;
  final String method;
  final String type;

  @override
  List<Object?> get props => [id, date, amount, method, type];
}

class PatientDetailInvoiceEntity extends Equatable {
  const PatientDetailInvoiceEntity({
    this.id = '',
    this.type = '',
    this.date = '',
    this.amount = 0,
    this.discount = 0,
    this.paid = 0,
    this.due = 0,
    this.status = '',
    this.payments = const [],
  });

  final String id;
  final String type;
  final String date;
  final double amount;
  final double discount;
  final double paid;
  final double due;
  final String status;
  final List<PatientDetailInvoicePaymentEntity> payments;

  @override
  List<Object?> get props => [
        id,
        type,
        date,
        amount,
        discount,
        paid,
        due,
        status,
        payments,
      ];
}
