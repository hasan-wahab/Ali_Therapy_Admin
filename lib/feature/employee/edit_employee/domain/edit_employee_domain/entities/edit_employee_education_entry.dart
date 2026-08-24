import 'package:equatable/equatable.dart';

// ============================================================
// EDIT EMPLOYEE EDUCATION ENTRY (Domain)
// ============================================================

class EditEmployeeEducationEntry extends Equatable {
  const EditEmployeeEducationEntry({
    this.id = '',
    this.degree = '',
    this.university = '',
    this.cgpa = '',
    this.comments = '',
  });

  final String id;
  final String degree;
  final String university;
  final String cgpa;
  final String comments;

  bool get isEmpty =>
      degree.trim().isEmpty &&
      university.trim().isEmpty &&
      cgpa.trim().isEmpty &&
      comments.trim().isEmpty;

  @override
  List<Object?> get props => [id, degree, university, cgpa, comments];
}
