import 'package:equatable/equatable.dart';

import 'package:ali_therapy_admin/core/utils/helpers.dart';

// ============================================================
// DASHBOARD OVERVIEW QUERY (Domain)
// ------------------------------------------------------------
// Query params for GET /api/admin/dashboard/overview
//   from_date, to_date, clinic_id
// ============================================================

class DashboardOverviewQuery extends Equatable {
  const DashboardOverviewQuery({
    this.fromDate,
    this.toDate,
    this.clinicId,
  });

  /// yyyy-MM-dd
  final String? fromDate;

  /// yyyy-MM-dd
  final String? toDate;
  final int? clinicId;

  /// Default range: first day → last day of the current month.
  factory DashboardOverviewQuery.currentMonth() {
    final now = DateTime.now();
    final from = DateTime(now.year, now.month, 1);
    final to = DateTime(now.year, now.month + 1, 0);
    return DashboardOverviewQuery(
      fromDate: Helpers.formatDate(from, pattern: 'yyyy-MM-dd'),
      toDate: Helpers.formatDate(to, pattern: 'yyyy-MM-dd'),
    );
  }

  Map<String, dynamic> toQueryParameters() {
    final params = <String, dynamic>{};
    if (fromDate != null && fromDate!.isNotEmpty) {
      params['from_date'] = fromDate;
    }
    if (toDate != null && toDate!.isNotEmpty) {
      params['to_date'] = toDate;
    }
    if (clinicId != null) params['clinic_id'] = clinicId;
    return params;
  }

  @override
  List<Object?> get props => [fromDate, toDate, clinicId];
}
