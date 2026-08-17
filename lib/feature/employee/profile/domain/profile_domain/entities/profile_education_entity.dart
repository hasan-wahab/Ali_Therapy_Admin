import 'package:equatable/equatable.dart';

// ============================================================
// PROFILE EDUCATION ENTITY (Domain)
// ------------------------------------------------------------
// One education row on the employee profile.
// ============================================================

class ProfileEducationEntity extends Equatable {
  final String id;
  final String degree;
  final String university;
  final String cgpa;
  final String comments;

  const ProfileEducationEntity({
    required this.id,
    required this.degree,
    required this.university,
    required this.cgpa,
    required this.comments,
  });

  @override
  List<Object?> get props => [id, degree, university, cgpa, comments];
}
