import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_page_entity.dart';
import 'package:ali_therapy_admin/feature/reports/domain/in_progress_sessions_domain/entities/in_progress_sessions_summary_entity.dart';

// ============================================================
// IN-PROGRESS SESSIONS MODEL (Data)
// ------------------------------------------------------------
// Parses one row from GET /api/admin/reports/in-progress-sessions
// ============================================================

class InProgressSessionsModel extends InProgressSessionsEntity {
  const InProgressSessionsModel({
    required super.id,
    required super.patientId,
    required super.patientName,
    required super.patientCnic,
    required super.mrNo,
    required super.sessionTypes,
    required super.consultantName,
    required super.therapistName,
    required super.clinicName,
    required super.startTime,
    required super.status,
  });

  factory InProgressSessionsModel.fromJson(Map<String, dynamic> json) {
    return InProgressSessionsModel(
      id: json['id']?.toString() ?? '',
      patientId: json['patient_id']?.toString() ?? '',
      patientName: _text(json['patient_name']),
      patientCnic: _text(json['patient_cnic']),
      mrNo: _text(json['mr_no']),
      sessionTypes: _stringList(json['session_types']),
      consultantName: _text(json['consultant_name']),
      therapistName: _text(json['therapist_name']),
      clinicName: _text(json['clinic_name']),
      startTime: _text(json['start_time']),
      status: _text(json['status']),
    );
  }

  static List<InProgressSessionsModel> listFromJson(List<dynamic> list) => list
      .whereType<Map>()
      .map(
        (e) => InProgressSessionsModel.fromJson(Map<String, dynamic>.from(e)),
      )
      .toList();

  InProgressSessionsEntity toEntity() => InProgressSessionsEntity(
        id: id,
        patientId: patientId,
        patientName: patientName,
        patientCnic: patientCnic,
        mrNo: mrNo,
        sessionTypes: sessionTypes,
        consultantName: consultantName,
        therapistName: therapistName,
        clinicName: clinicName,
        startTime: startTime,
        status: status,
      );
}

class InProgressSessionsPageModel extends InProgressSessionsPageEntity {
  const InProgressSessionsPageModel({
    required super.rows,
    required super.currentPage,
    required super.lastPage,
    required super.total,
    super.summary,
  });

  factory InProgressSessionsPageModel.fromJson(Map<String, dynamic> json) {
    final list = json['data'];
    final rows = list is List
        ? InProgressSessionsModel.listFromJson(list)
        : <InProgressSessionsModel>[];

    final currentPage = _toInt(json['current_page'], fallback: 1);
    final nextPageUrl = json['next_page_url']?.toString().trim() ?? '';
    final lastPage = json['last_page'] != null
        ? _toInt(json['last_page'], fallback: currentPage)
        : (nextPageUrl.isNotEmpty ? currentPage + 1 : currentPage);
    final total = _toInt(json['total'], fallback: rows.length);

    return InProgressSessionsPageModel(
      rows: rows,
      currentPage: currentPage,
      lastPage: lastPage,
      total: total,
      summary: InProgressSessionsSummaryModel.fromJson(
        json,
        sessionCount: total,
      ),
    );
  }

  InProgressSessionsPageEntity toEntity() => InProgressSessionsPageEntity(
        rows: rows,
        currentPage: currentPage,
        lastPage: lastPage,
        total: total,
        summary: summary,
      );
}

class InProgressSessionsSummaryModel extends InProgressSessionsSummaryEntity {
  const InProgressSessionsSummaryModel({
    required super.totalInProgress,
    required super.consultationsActive,
    required super.therapyActive,
    required super.clinicsActive,
  });

  factory InProgressSessionsSummaryModel.fromJson(
    Map<String, dynamic> json, {
    required int sessionCount,
  }) {
    final totals = _asMap(json['totals']) ??
        _asMap(json['summary']) ??
        _asMap(json['stats']) ??
        json;

    final total = _toInt(
      totals['total_in_progress'] ??
          totals['in_progress'] ??
          totals['live_sessions'],
    );
    final consultations = _toInt(
      totals['consultations_active'] ??
          totals['consultations'] ??
          totals['consultation_count'],
    );
    final therapy = _toInt(
      totals['therapy_active'] ??
          totals['therapy'] ??
          totals['therapy_count'],
    );
    final clinics = _toInt(
      totals['clinics_active'] ??
          totals['active_clinics'] ??
          totals['clinic_count'],
    );

    if (total == 0 && consultations == 0 && therapy == 0 && clinics == 0) {
      return const InProgressSessionsSummaryModel(
        totalInProgress: 0,
        consultationsActive: 0,
        therapyActive: 0,
        clinicsActive: 0,
      );
    }

    return InProgressSessionsSummaryModel(
      totalInProgress: total == 0 ? sessionCount : total,
      consultationsActive: consultations,
      therapyActive: therapy,
      clinicsActive: clinics,
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

List<String> _stringList(dynamic value) {
  if (value is! List) return const [];
  return value
      .map((e) => e.toString().trim())
      .where((e) => e.isNotEmpty)
      .toList();
}

int _toInt(dynamic value, {int fallback = 0}) {
  if (value == null) return fallback;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? fallback;
}
