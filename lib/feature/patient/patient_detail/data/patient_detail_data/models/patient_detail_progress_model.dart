import '../../../domain/patient_detail_domain/entities/patient_detail_progress_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL PROGRESS MODEL
// ------------------------------------------------------------
// Parses one item from data.patient_progress
// ============================================================

class PatientDetailProgressEventModel
    extends PatientDetailProgressEventEntity {
  const PatientDetailProgressEventModel({
    super.kind,
    super.time,
    super.staffName,
    super.status,
    super.packageLine,
    super.startTime,
    super.endTime,
    super.duration,
  });

  factory PatientDetailProgressEventModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailProgressEventModel(
      kind: PatientDetailJsonHelpers.text(json['kind']),
      time: PatientDetailJsonHelpers.textOf(json, const [
        'time',
        'time_label',
        'at',
      ]),
      staffName: PatientDetailJsonHelpers.textOf(json, const [
        'staff_name',
        'staff',
        'name',
      ]),
      status: PatientDetailJsonHelpers.text(json['status']),
      packageLine: PatientDetailJsonHelpers.textOf(json, const [
        'package_line',
        'package',
        'package_name',
      ]),
      startTime: PatientDetailJsonHelpers.textOf(json, const [
        'start_time',
        'started_at',
      ]),
      endTime: PatientDetailJsonHelpers.textOf(json, const [
        'end_time',
        'ended_at',
      ]),
      duration: PatientDetailJsonHelpers.text(json['duration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kind': kind,
      'time': time,
      'staff_name': staffName,
      'status': status,
      'package_line': packageLine,
      'start_time': startTime,
      'end_time': endTime,
      'duration': duration,
    };
  }

  PatientDetailProgressEventEntity toEntity() {
    return PatientDetailProgressEventEntity(
      kind: kind,
      time: time,
      staffName: staffName,
      status: status,
      packageLine: packageLine,
      startTime: startTime,
      endTime: endTime,
      duration: duration,
    );
  }
}

class PatientDetailProgressVisitModel
    extends PatientDetailProgressVisitEntity {
  const PatientDetailProgressVisitModel({
    super.visitNumber,
    super.visitId,
    super.dateTime,
    super.visitType,
    super.status,
    super.events,
  });

  factory PatientDetailProgressVisitModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailProgressVisitModel(
      visitNumber: PatientDetailJsonHelpers.integer(json['visit_number']),
      visitId: PatientDetailJsonHelpers.textOf(json, const [
        'visit_id',
        'id',
      ]),
      dateTime: PatientDetailJsonHelpers.textOf(json, const [
        'date_time',
        'datetime',
        'date',
      ]),
      visitType: PatientDetailJsonHelpers.textOf(json, const [
        'visit_type',
        'type',
      ]),
      status: PatientDetailJsonHelpers.text(json['status']),
      events: PatientDetailJsonHelpers.mapList(
        json['events'],
        PatientDetailProgressEventModel.fromJson,
      ),
    );
  }

  static List<PatientDetailProgressVisitModel> listFromJson(dynamic raw) {
    return PatientDetailJsonHelpers.mapList(
      raw,
      PatientDetailProgressVisitModel.fromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visit_number': visitNumber,
      'visit_id': visitId,
      'date_time': dateTime,
      'visit_type': visitType,
      'status': status,
      'events': events
          .map(
            (item) => item is PatientDetailProgressEventModel
                ? item.toJson()
                : PatientDetailProgressEventModel(
                    kind: item.kind,
                    time: item.time,
                    staffName: item.staffName,
                    status: item.status,
                    packageLine: item.packageLine,
                    startTime: item.startTime,
                    endTime: item.endTime,
                    duration: item.duration,
                  ).toJson(),
          )
          .toList(),
    };
  }

  PatientDetailProgressVisitEntity toEntity() {
    return PatientDetailProgressVisitEntity(
      visitNumber: visitNumber,
      visitId: visitId,
      dateTime: dateTime,
      visitType: visitType,
      status: status,
      events: events
          .map(
            (item) => item is PatientDetailProgressEventModel
                ? item.toEntity()
                : PatientDetailProgressEventEntity(
                    kind: item.kind,
                    time: item.time,
                    staffName: item.staffName,
                    status: item.status,
                    packageLine: item.packageLine,
                    startTime: item.startTime,
                    endTime: item.endTime,
                    duration: item.duration,
                  ),
          )
          .toList(),
    );
  }
}
