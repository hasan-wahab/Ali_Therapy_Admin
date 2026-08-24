import '../../../domain/free_consultation_report_domain/entities/free_consultation_report_entity.dart';
import '../../../domain/free_consultation_report_domain/entities/free_consultation_report_page_entity.dart';
import '../../../domain/free_consultation_report_domain/entities/free_consultation_report_summary_entity.dart';

// ============================================================
// FREE CONSULTATION REPORT MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/free-consultation
// ============================================================

class FreeConsultationReportModel extends FreeConsultationReportEntity {
  const FreeConsultationReportModel({
    required super.id,
    required super.visitDate,
    required super.patientName,
    required super.patientPhone,
    required super.patientCnic,
    required super.consultantName,
    required super.clinicName,
    required super.fee,
  });

  factory FreeConsultationReportModel.fromJson(Map<String, dynamic> json) {
    return FreeConsultationReportModel(
      id: json['id']?.toString() ?? '',
      visitDate: json['visit_date']?.toString().trim() ?? '',
      patientName: json['patient_name']?.toString().trim() ?? '',
      patientPhone: json['patient_phone']?.toString().trim() ?? '',
      patientCnic: json['patient_cnic']?.toString().trim() ?? '',
      consultantName: json['consultant_name']?.toString().trim() ?? '',
      clinicName: json['clinic_name']?.toString().trim() ?? '',
      fee: _toDouble(json['fee']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  static List<FreeConsultationReportModel> listFromJson(List<dynamic> list) =>
      list
          .whereType<Map>()
          .map((e) => FreeConsultationReportModel.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList();

  FreeConsultationReportEntity toEntity() => FreeConsultationReportEntity(
        id: id,
        visitDate: visitDate,
        patientName: patientName,
        patientPhone: patientPhone,
        patientCnic: patientCnic,
        consultantName: consultantName,
        clinicName: clinicName,
        fee: fee,
      );
}

// ============================================================
// FREE CONSULTATION REPORT PAGE MODEL
// ------------------------------------------------------------
// Wraps Laravel paginate response.
// ============================================================

class FreeConsultationReportPageModel extends FreeConsultationReportPageEntity {
  const FreeConsultationReportPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory FreeConsultationReportPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? FreeConsultationReportModel.listFromJson(list)
        : <FreeConsultationReportModel>[];

    final total = (json['total'] as num?)?.toInt() ?? rows.length;

    return FreeConsultationReportPageModel(
      rows: rows,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      total: total,
      summary: FreeConsultationReportSummaryModel.fromJson(
        json,
        freeConsultationCount: total,
      ),
    );
  }

  FreeConsultationReportPageEntity toEntity() =>
      FreeConsultationReportPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );
}

class FreeConsultationReportSummaryModel
    extends FreeConsultationReportSummaryEntity {
  const FreeConsultationReportSummaryModel({
    required super.totalFreeConsultations,
    super.clinics,
  });

  factory FreeConsultationReportSummaryModel.fromJson(
    Map<String, dynamic> json, {
    required int freeConsultationCount,
  }) {
    final totals = _asMap(json['totals']) ??
        _asMap(json['summary']) ??
        _asMap(json['stats']) ??
        json;

    final count = _toInt(
      totals['total_free_consultations'] ??
          totals['free_consultations'] ??
          totals['free_consultation_count'] ??
          totals['total_consultations'] ??
          totals['total_visits'],
    );
    final clinics = _clinicsFrom(totals);

    if (count == 0 && clinics.isEmpty) {
      return const FreeConsultationReportSummaryModel(
        totalFreeConsultations: 0,
        clinics: [],
      );
    }

    return FreeConsultationReportSummaryModel(
      totalFreeConsultations: count == 0 ? freeConsultationCount : count,
      clinics: clinics,
    );
  }

  static List<FreeConsultationReportClinicCountEntity> _clinicsFrom(
    Map<String, dynamic> json,
  ) {
    final raw = json['clinics'] ??
        json['clinic_visits'] ??
        json['by_clinic'] ??
        json['clinic_stats'];
    if (raw is List) {
      final result = <FreeConsultationReportClinicCountEntity>[];
      for (final item in raw) {
        final map = _asMap(item);
        if (map == null) continue;
        final name = (map['clinic_name'] ?? map['name'] ?? map['clinic'])
            ?.toString()
            .trim();
        if (name == null || name.isEmpty) continue;
        result.add(
          FreeConsultationReportClinicCountEntity(
            name: name,
            freeConsultations: _toInt(
              map['free_consultations'] ??
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
        FreeConsultationReportClinicCountEntity(
          name: entry.key,
          freeConsultations: _toInt(entry.value),
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
