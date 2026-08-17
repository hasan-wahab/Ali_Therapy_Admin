import 'package:equatable/equatable.dart';

// ============================================================
// PROFILE EXPERIENCE ENTITY (Domain)
// ------------------------------------------------------------
// One experience row on the employee profile.
// ============================================================

class ProfileExperienceEntity extends Equatable {
  final String id;
  final String companyName;
  final String workingPeriod;
  final String duties;
  final String supervisor;

  const ProfileExperienceEntity({
    required this.id,
    required this.companyName,
    required this.workingPeriod,
    required this.duties,
    required this.supervisor,
  });

  @override
  List<Object?> get props => [
        id,
        companyName,
        workingPeriod,
        duties,
        supervisor,
      ];
}
