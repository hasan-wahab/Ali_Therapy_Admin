import '../../../domain/reconsultation_report_domain/entities/reconsultation_report_entity.dart';
import '../../../domain/reconsultation_report_domain/entities/reconsultation_report_page_entity.dart';
import '../../../domain/reconsultation_report_domain/entities/reconsultation_report_summary_entity.dart';

// ============================================================
// RECONSULTATION REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/reconsultation
// ============================================================

class ReconsultationReportModel extends ReconsultationReportEntity {
  const ReconsultationReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.consultantName,
    required super.clinicName,
  });

  factory ReconsultationReportModel.fromJson(Map<String, dynamic> json) {
    return ReconsultationReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      consultantName: json['consultant_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
    );
  }

  static List<ReconsultationReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => ReconsultationReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  ReconsultationReportEntity toEntity() => ReconsultationReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        consultantName: consultantName,
        clinicName: clinicName,
      );
}

// ============================================================
// RECONSULTATION REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class ReconsultationReportPageModel extends ReconsultationReportPageEntity {
  const ReconsultationReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory ReconsultationReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? ReconsultationReportModel.listFromJson(list)
        : <ReconsultationReportModel>[];

    final total = (json['total'] as num?)?.toInt() ?? rows.length;

    return ReconsultationReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: total,
      summary: ReconsultationReportSummaryModel.fromJson(
        json,
        reconsultationCount: total,
      ),
    );
  }

  ReconsultationReportPageEntity toEntity() => ReconsultationReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );
}

class ReconsultationReportSummaryModel extends ReconsultationReportSummaryEntity {
  const ReconsultationReportSummaryModel({
    required super.totalReconsultations,
    super.clinics,
  });

  factory ReconsultationReportSummaryModel.fromJson(
    Map<String, dynamic> json, {
    required int reconsultationCount,
  }) {
    final totals = _asMap(json['totals']) ??
        _asMap(json['summary']) ??
        _asMap(json['stats']) ??
        json;

    final count = _toInt(
      totals['total_reconsultations'] ??
          totals['reconsultations'] ??
          totals['reconsultation_count'] ??
          totals['total_consultations'] ??
          totals['total_visits'],
    );
    final clinics = _clinicsFrom(totals);

    if (count == 0 && clinics.isEmpty) {
      return const ReconsultationReportSummaryModel(
        totalReconsultations: 0,
        clinics: [],
      );
    }

    return ReconsultationReportSummaryModel(
      totalReconsultations: count == 0 ? reconsultationCount : count,
      clinics: clinics,
    );
  }

  static List<ReconsultationReportClinicCountEntity> _clinicsFrom(
    Map<String, dynamic> json,
  ) {
    final raw = json['clinics'] ??
        json['clinic_visits'] ??
        json['by_clinic'] ??
        json['clinic_stats'];
    if (raw is List) {
      final result = <ReconsultationReportClinicCountEntity>[];
      for (final item in raw) {
        final map = _asMap(item);
        if (map == null) continue;
        final name = (map['clinic_name'] ?? map['name'] ?? map['clinic'])
            ?.toString()
            .trim();
        if (name == null || name.isEmpty) continue;
        result.add(
          ReconsultationReportClinicCountEntity(
            name: name,
            reconsultations: _toInt(
              map['reconsultations'] ??
                  map['consultations'] ??
                  map['visits'] ??
                  map['count'] ??
                  map['total'],
            ),
          ),
        );
      }
      return result;
    }
    final map = _asMap(raw);
    if (map == null) return const [];
    return [
      for (final entry in map.entries)
        ReconsultationReportClinicCountEntity(
          name: entry.key,
          reconsultations: _toInt(entry.value),
        ),
    ];
  }

  static Map<String, dynamic>? _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
