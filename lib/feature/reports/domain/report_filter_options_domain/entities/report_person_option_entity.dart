import 'package:equatable/equatable.dart';

// ============================================================
// REPORT PERSON OPTION ENTITY (Domain)
// ------------------------------------------------------------
// One person (consultant, therapist, receptionist, etc.)
// in a report filter dropdown.
// ============================================================

class ReportPersonOptionEntity extends Equatable {
  const ReportPersonOptionEntity({
    required this.id,
    required this.name,
    this.profilePicture,
  });

  final int id;
  final String name;

  /// Optional avatar URL (may be null or a generic placeholder).
  final String? profilePicture;

  @override
  List<Object?> get props => [id, name, profilePicture];
}
