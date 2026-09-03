import '../../../domain/patient_detail_domain/entities/patient_detail_session_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL SESSION MODEL
// ------------------------------------------------------------
// Parses one item from data.sessions
// ============================================================

class PatientDetailModalityModel extends PatientDetailModalityEntity {
  const PatientDetailModalityModel({
    super.title,
    super.duration,
  });

  factory PatientDetailModalityModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailModalityModel(
      title: PatientDetailJsonHelpers.text(json['title']),
      duration: PatientDetailJsonHelpers.text(json['duration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'duration': duration,
    };
  }

  PatientDetailModalityEntity toEntity() {
    return PatientDetailModalityEntity(title: title, duration: duration);
  }
}

class PatientDetailNextSessionModel extends PatientDetailNextSessionEntity {
  const PatientDetailNextSessionModel({
    super.date,
    super.timeSlot,
    super.status,
  });

  factory PatientDetailNextSessionModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailNextSessionModel(
      date: PatientDetailJsonHelpers.text(json['date']),
      timeSlot: PatientDetailJsonHelpers.text(json['time_slot']),
      status: PatientDetailJsonHelpers.text(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time_slot': timeSlot,
      'status': status,
    };
  }

  PatientDetailNextSessionEntity toEntity() {
    return PatientDetailNextSessionEntity(
      date: date,
      timeSlot: timeSlot,
      status: status,
    );
  }
}

class PatientDetailSessionModel extends PatientDetailSessionEntity {
  const PatientDetailSessionModel({
    super.id,
    super.sessionNumber,
    super.patientName,
    super.cnic,
    super.age,
    super.gender,
    super.therapist,
    super.packageName,
    super.duration,
    super.startedAt,
    super.endedAt,
    super.modalities,
    super.nextSession,
  });

  factory PatientDetailSessionModel.fromJson(Map<String, dynamic> json) {
    final nextJson = PatientDetailJsonHelpers.mapOrNull(json['next_session']);

    return PatientDetailSessionModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      sessionNumber: PatientDetailJsonHelpers.integer(json['session_number']),
      patientName: PatientDetailJsonHelpers.text(json['patient_name']),
      cnic: PatientDetailJsonHelpers.text(json['cnic']),
      age: PatientDetailJsonHelpers.integer(json['age']),
      gender: PatientDetailJsonHelpers.text(json['gender']),
      therapist: PatientDetailJsonHelpers.text(json['therapist']),
      packageName: PatientDetailJsonHelpers.text(json['package_name']),
      duration: PatientDetailJsonHelpers.text(json['duration']),
      startedAt: PatientDetailJsonHelpers.text(json['started_at']),
      endedAt: PatientDetailJsonHelpers.text(json['ended_at']),
      modalities: PatientDetailJsonHelpers.mapList(
        json['modalities'],
        PatientDetailModalityModel.fromJson,
      ),
      nextSession: nextJson == null
          ? const PatientDetailNextSessionModel()
          : PatientDetailNextSessionModel.fromJson(nextJson),
    );
  }

  static List<PatientDetailSessionModel> listFromJson(dynamic raw) {
    return PatientDetailJsonHelpers.mapList(
      raw,
      PatientDetailSessionModel.fromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_number': sessionNumber,
      'patient_name': patientName,
      'cnic': cnic,
      'age': age,
      'gender': gender,
      'therapist': therapist,
      'package_name': packageName,
      'duration': duration,
      'started_at': startedAt,
      'ended_at': endedAt,
      'modalities': modalities
          .map(
            (item) => item is PatientDetailModalityModel
                ? item.toJson()
                : PatientDetailModalityModel(
                    title: item.title,
                    duration: item.duration,
                  ).toJson(),
          )
          .toList(),
      'next_session': nextSession is PatientDetailNextSessionModel
          ? (nextSession as PatientDetailNextSessionModel).toJson()
          : PatientDetailNextSessionModel(
              date: nextSession.date,
              timeSlot: nextSession.timeSlot,
              status: nextSession.status,
            ).toJson(),
    };
  }

  PatientDetailSessionEntity toEntity() {
    return PatientDetailSessionEntity(
      id: id,
      sessionNumber: sessionNumber,
      patientName: patientName,
      cnic: cnic,
      age: age,
      gender: gender,
      therapist: therapist,
      packageName: packageName,
      duration: duration,
      startedAt: startedAt,
      endedAt: endedAt,
      modalities: modalities
          .map(
            (item) => item is PatientDetailModalityModel
                ? item.toEntity()
                : PatientDetailModalityEntity(
                    title: item.title,
                    duration: item.duration,
                  ),
          )
          .toList(),
      nextSession: nextSession is PatientDetailNextSessionModel
          ? (nextSession as PatientDetailNextSessionModel).toEntity()
          : PatientDetailNextSessionEntity(
              date: nextSession.date,
              timeSlot: nextSession.timeSlot,
              status: nextSession.status,
            ),
    );
  }
}
