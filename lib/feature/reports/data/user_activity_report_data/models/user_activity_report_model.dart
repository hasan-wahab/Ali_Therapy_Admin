import '../../../domain/user_activity_report_domain/entities/user_activity_report_entity.dart';
import '../../../domain/user_activity_report_domain/entities/user_activity_report_page_entity.dart';

// ============================================================
// USER ACTIVITY REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/user-activity
// ============================================================

class UserActivityReportModel extends UserActivityReportEntity {
  const UserActivityReportModel({
    required super.id,
    required super.patientName,
    required super.patientCnic,
    required super.packageName,
    required super.sessionsUsed,
    required super.sessionsTotal,
    required super.remaining,
    required super.invoiceType,
    required super.paymentDate,
    required super.paymentMethod,
    required super.amount,
  });

  factory UserActivityReportModel.fromJson(Map<String, dynamic> json) {
    return UserActivityReportModel(
      id: json['id']?.toString() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      packageName: json['package_name']?.toString().trim() ?? '',
      sessionsUsed: _toInt(json['sessions_used']),
      sessionsTotal: _toInt(json['sessions_total']),
      remaining: _toInt(json['remaining']),
      invoiceType: json['invoice_type']?.toString().trim() ?? '',
      paymentDate: json['payment_date']?.toString().trim() ?? '',
      paymentMethod: json['payment_method']?.toString().trim() ?? '',
      amount: _toDouble(json['amount']),
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

  static List<UserActivityReportModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map(
        (e) => UserActivityReportModel.fromJson(Map<String, dynamic>.from(e)),
      )
      .toList();

  UserActivityReportEntity toEntity() => UserActivityReportEntity(
        id: id,
        patientName: patientName,
        patientCnic: patientCnic,
        packageName: packageName,
        sessionsUsed: sessionsUsed,
        sessionsTotal: sessionsTotal,
        remaining: remaining,
        invoiceType: invoiceType,
        paymentDate: paymentDate,
        paymentMethod: paymentMethod,
        amount: amount,
      );
}

// ============================================================
// USER ACTIVITY REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class UserActivityReportPageModel extends UserActivityReportPageEntity {
  const UserActivityReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory UserActivityReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? UserActivityReportModel.listFromJson(list)
        : <UserActivityReportModel>[];

    return UserActivityReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? rows.length,
    );
  }

  UserActivityReportPageEntity toEntity() => UserActivityReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
      );
}
