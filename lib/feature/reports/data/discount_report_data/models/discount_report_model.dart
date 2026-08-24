import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/discount_report_domain/entities/discount_report_summary_entity.dart';

// ============================================================
// DISCOUNT REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/discount
// ============================================================

class DiscountReportModel extends DiscountReportEntity {
  const DiscountReportModel({
    required super.id,
    required super.patientName,
    required super.patientCnic,
    required super.patientPhone,
    required super.consultantName,
    required super.clinicName,
    required super.receptionistName,
    required super.grossAmount,
    required super.discount,
    required super.insuranceDiscount,
    required super.totalDiscount,
    required super.netAmount,
    required super.paidAmount,
    required super.remainingAmount,
  });

  factory DiscountReportModel.fromJson(Map<String, dynamic> json) {
    return DiscountReportModel(
      id: json['id']?.toString() ?? '',
      patientName: _text(json['patient_name']),
      patientCnic: _text(json['patient_cnic']),
      patientPhone: _text(json['patient_phone']),
      consultantName: _text(json['consultant_name']),
      clinicName: _text(json['clinic_name']),
      receptionistName: _text(json['receptionist_name']),
      grossAmount: _money(json['gross_amount']),
      discount: _money(json['discount']),
      insuranceDiscount: _money(json['insurance_discount']),
      totalDiscount: _money(json['total_discount']),
      netAmount: _money(json['net_amount']),
      paidAmount: _money(json['paid_amount']),
      remainingAmount: _money(json['remaining_amount']),
    );
  }

  static List<DiscountReportModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map((e) => DiscountReportModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  DiscountReportEntity toEntity() => DiscountReportEntity(
        id: id,
        patientName: patientName,
        patientCnic: patientCnic,
        patientPhone: patientPhone,
        consultantName: consultantName,
        clinicName: clinicName,
        receptionistName: receptionistName,
        grossAmount: grossAmount,
        discount: discount,
        insuranceDiscount: insuranceDiscount,
        totalDiscount: totalDiscount,
        netAmount: netAmount,
        paidAmount: paidAmount,
        remainingAmount: remainingAmount,
      );
}

class DiscountReportPageModel extends DiscountReportPageEntity {
  const DiscountReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory DiscountReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? DiscountReportModel.listFromJson(list)
        : <DiscountReportModel>[];

    final currentPage = _toInt(json['current_page'], fallback: 1);
    final nextPageUrl = json['next_page_url']?.toString().trim() ?? '';
    final lastPage = json['last_page'] != null
        ? _toInt(json['last_page'], fallback: currentPage)
        : (nextPageUrl.isNotEmpty ? currentPage + 1 : currentPage);
    final total = _toInt(json['total'], fallback: rows.length);

    return DiscountReportPageModel(
      rows: rows,
      currentPage: currentPage,
      lastPage: lastPage,
      total: total,
      summary: DiscountReportSummaryModel.fromJson(json, invoiceCount: total),
    );
  }

  DiscountReportPageEntity toEntity() => DiscountReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );
}

class DiscountReportSummaryModel extends DiscountReportSummaryEntity {
  const DiscountReportSummaryModel({
    required super.discountedInvoices,
    required super.totalGrossBilled,
    required super.totalDiscountGiven,
    required super.netBilledAmount,
  });

  factory DiscountReportSummaryModel.fromJson(
    Map<String, dynamic> json, {
    required int invoiceCount,
  }) {
    final totals = _asMap(json['totals']) ??
        _asMap(json['summary']) ??
        _asMap(json['stats']) ??
        json;

    final invoices = _toInt(
      totals['discounted_invoices'] ??
          totals['total_invoices'] ??
          totals['invoice_count'],
      fallback: 0,
    );
    final gross = _money(
      totals['total_gross_billed'] ??
          totals['gross_billed'] ??
          totals['gross_amount'],
    );
    final discount = _money(
      totals['total_discount_given'] ??
          totals['total_discount'] ??
          totals['discount'],
    );
    final net = _money(
      totals['net_billed_amount'] ??
          totals['net_amount'] ??
          totals['net_billed'],
    );

    if (invoices == 0 && gross == 0 && discount == 0 && net == 0) {
      return const DiscountReportSummaryModel(
        discountedInvoices: 0,
        totalGrossBilled: 0,
        totalDiscountGiven: 0,
        netBilledAmount: 0,
      );
    }

    return DiscountReportSummaryModel(
      discountedInvoices: invoices == 0 ? invoiceCount : invoices,
      totalGrossBilled: gross,
      totalDiscountGiven: discount,
      netBilledAmount: net,
    );
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }
}

String _text(dynamic value) {
  if (value == null) return '_';
  final text = value.toString().trim();
  return text.isEmpty ? '_' : text;
}

/// Round money to 2 decimals so float leftovers (e.g. 35000.0099) display clean.
double _money(dynamic value) {
  if (value == null) return 0;
  final parsed = value is num
      ? value.toDouble()
      : double.tryParse(value.toString()) ?? 0;
  return (parsed * 100).round() / 100;
}

int _toInt(dynamic value, {int fallback = 0}) {
  if (value == null) return fallback;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? fallback;
}
