import 'package:equatable/equatable.dart';

// ============================================================
// PACKAGE ATTENDANCE SESSION ENTITY (Domain)
// ------------------------------------------------------------
// One attended session in sessions_history.
// ============================================================

class PackageAttendanceSessionEntity extends Equatable {
  const PackageAttendanceSessionEntity({
    required this.sessionNumber,
    required this.date,
    required this.therapistName,
    required this.clinicName,
    required this.timeDuration,
    required this.status,
    required this.notes,
  });

  final int sessionNumber;
  final String date;
  final String therapistName;
  final String clinicName;
  final String timeDuration;
  final String status;
  final String notes;

  bool get hasNotes {
    final trimmed = notes.trim();
    return trimmed.isNotEmpty && trimmed != '_';
  }

  @override
  List<Object?> get props => [
        sessionNumber,
        date,
        therapistName,
        clinicName,
        timeDuration,
        status,
        notes,
      ];
}
