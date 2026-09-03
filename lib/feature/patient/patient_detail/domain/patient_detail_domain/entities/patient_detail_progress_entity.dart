import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL PROGRESS (Domain)
// ------------------------------------------------------------
// API: data.patient_progress[]
// ============================================================

class PatientDetailProgressEventEntity extends Equatable {
  const PatientDetailProgressEventEntity({
    this.kind = '',
    this.time = '',
    this.staffName = '',
    this.status = '',
    this.packageLine = '',
    this.startTime = '',
    this.endTime = '',
    this.duration = '',
  });

  final String kind;
  final String time;
  final String staffName;
  final String status;
  final String packageLine;
  final String startTime;
  final String endTime;
  final String duration;

  @override
  List<Object?> get props => [
        kind,
        time,
        staffName,
        status,
        packageLine,
        startTime,
        endTime,
        duration,
      ];
}

class PatientDetailProgressVisitEntity extends Equatable {
  const PatientDetailProgressVisitEntity({
    this.visitNumber = 0,
    this.visitId = '',
    this.dateTime = '',
    this.visitType = '',
    this.status = '',
    this.events = const [],
  });

  final int visitNumber;
  final String visitId;
  final String dateTime;
  final String visitType;
  final String status;
  final List<PatientDetailProgressEventEntity> events;

  @override
  List<Object?> get props => [
        visitNumber,
        visitId,
        dateTime,
        visitType,
        status,
        events,
      ];
}
