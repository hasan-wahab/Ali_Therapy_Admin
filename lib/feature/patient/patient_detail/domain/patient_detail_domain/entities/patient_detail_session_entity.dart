import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL SESSION (Domain)
// ------------------------------------------------------------
// API: data.sessions[]
// ============================================================

class PatientDetailModalityEntity extends Equatable {
  const PatientDetailModalityEntity({
    this.title = '',
    this.duration = '',
  });

  final String title;
  final String duration;

  @override
  List<Object?> get props => [title, duration];
}

class PatientDetailNextSessionEntity extends Equatable {
  const PatientDetailNextSessionEntity({
    this.date = '',
    this.timeSlot = '',
    this.status = '',
  });

  final String date;
  final String timeSlot;
  final String status;

  @override
  List<Object?> get props => [date, timeSlot, status];
}

class PatientDetailSessionEntity extends Equatable {
  const PatientDetailSessionEntity({
    this.id = '',
    this.sessionNumber = 0,
    this.patientName = '',
    this.cnic = '',
    this.age = 0,
    this.gender = '',
    this.therapist = '',
    this.packageName = '',
    this.duration = '',
    this.startedAt = '',
    this.endedAt = '',
    this.modalities = const [],
    this.nextSession = const PatientDetailNextSessionEntity(),
  });

  final String id;
  final int sessionNumber;
  final String patientName;
  final String cnic;
  final int age;
  final String gender;
  final String therapist;
  final String packageName;
  final String duration;
  final String startedAt;
  final String endedAt;
  final List<PatientDetailModalityEntity> modalities;
  final PatientDetailNextSessionEntity nextSession;

  @override
  List<Object?> get props => [
        id,
        sessionNumber,
        patientName,
        cnic,
        age,
        gender,
        therapist,
        packageName,
        duration,
        startedAt,
        endedAt,
        modalities,
        nextSession,
      ];
}
