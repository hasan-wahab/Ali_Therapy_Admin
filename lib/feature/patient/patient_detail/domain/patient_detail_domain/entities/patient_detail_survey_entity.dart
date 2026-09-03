import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL SURVEY (Domain)
// ------------------------------------------------------------
// API: data.surveys[]
// ============================================================

class PatientDetailSurveyQuestionEntity extends Equatable {
  const PatientDetailSurveyQuestionEntity({
    this.question = '',
    this.type = '',
    this.options = const [],
    this.selected = '',
    this.rating = 0,
    this.textAnswer = '',
  });

  final String question;
  final String type;
  final List<String> options;
  final String selected;
  final int rating;
  final String textAnswer;

  @override
  List<Object?> get props => [
        question,
        type,
        options,
        selected,
        rating,
        textAnswer,
      ];
}

class PatientDetailSurveyEntity extends Equatable {
  const PatientDetailSurveyEntity({
    this.visitId = '',
    this.visitNumber = 0,
    this.visitTitle = '',
    this.visitDate = '',
    this.therapist = '',
    this.submittedAt = '',
    this.questions = const [],
  });

  final String visitId;
  final int visitNumber;
  final String visitTitle;
  final String visitDate;
  final String therapist;
  final String submittedAt;
  final List<PatientDetailSurveyQuestionEntity> questions;

  @override
  List<Object?> get props => [
        visitId,
        visitNumber,
        visitTitle,
        visitDate,
        therapist,
        submittedAt,
        questions,
      ];
}
