import '../../../domain/patient_detail_domain/entities/patient_detail_survey_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL SURVEY MODEL
// ------------------------------------------------------------
// Parses one item from data.surveys
// ============================================================

class PatientDetailSurveyQuestionModel
    extends PatientDetailSurveyQuestionEntity {
  const PatientDetailSurveyQuestionModel({
    super.question,
    super.type,
    super.options,
    super.selected,
    super.rating,
    super.textAnswer,
  });

  factory PatientDetailSurveyQuestionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PatientDetailSurveyQuestionModel(
      question: PatientDetailJsonHelpers.textOf(json, const [
        'question',
        'title',
        'label',
      ]),
      type: PatientDetailJsonHelpers.textOf(json, const [
        'type',
        'kind',
        'answer_type',
      ]),
      options: PatientDetailJsonHelpers.stringList(json['options']),
      selected: PatientDetailJsonHelpers.textOf(json, const [
        'selected',
        'choice',
        'value',
      ]),
      rating: PatientDetailJsonHelpers.integer(
        json['rating'] ?? json['stars'] ?? json['score'],
      ),
      textAnswer: PatientDetailJsonHelpers.textOf(json, const [
        'text_answer',
        'text',
        'comment',
        'answer',
      ]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'type': type,
      'options': options,
      'selected': selected,
      'rating': rating,
      'text_answer': textAnswer,
    };
  }

  PatientDetailSurveyQuestionEntity toEntity() {
    return PatientDetailSurveyQuestionEntity(
      question: question,
      type: type,
      options: options,
      selected: selected,
      rating: rating,
      textAnswer: textAnswer,
    );
  }
}

class PatientDetailSurveyModel extends PatientDetailSurveyEntity {
  const PatientDetailSurveyModel({
    super.visitId,
    super.visitNumber,
    super.visitTitle,
    super.visitDate,
    super.therapist,
    super.submittedAt,
    super.questions,
  });

  factory PatientDetailSurveyModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailSurveyModel(
      visitId: PatientDetailJsonHelpers.textOf(json, const [
        'visit_id',
        'id',
      ]),
      visitNumber: PatientDetailJsonHelpers.integer(json['visit_number']),
      visitTitle: PatientDetailJsonHelpers.textOf(json, const [
        'visit_title',
        'title',
      ]),
      visitDate: PatientDetailJsonHelpers.textOf(json, const [
        'visit_date',
        'date',
      ]),
      therapist: PatientDetailJsonHelpers.text(json['therapist']),
      submittedAt: PatientDetailJsonHelpers.textOf(json, const [
        'submitted_at',
        'created_at',
      ]),
      questions: PatientDetailJsonHelpers.mapList(
        json['questions'],
        PatientDetailSurveyQuestionModel.fromJson,
      ),
    );
  }

  static List<PatientDetailSurveyModel> listFromJson(dynamic raw) {
    return PatientDetailJsonHelpers.mapList(
      raw,
      PatientDetailSurveyModel.fromJson,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visit_id': visitId,
      'visit_number': visitNumber,
      'visit_title': visitTitle,
      'visit_date': visitDate,
      'therapist': therapist,
      'submitted_at': submittedAt,
      'questions': questions
          .map(
            (item) => item is PatientDetailSurveyQuestionModel
                ? item.toJson()
                : PatientDetailSurveyQuestionModel(
                    question: item.question,
                    type: item.type,
                    options: item.options,
                    selected: item.selected,
                    rating: item.rating,
                    textAnswer: item.textAnswer,
                  ).toJson(),
          )
          .toList(),
    };
  }

  PatientDetailSurveyEntity toEntity() {
    return PatientDetailSurveyEntity(
      visitId: visitId,
      visitNumber: visitNumber,
      visitTitle: visitTitle,
      visitDate: visitDate,
      therapist: therapist,
      submittedAt: submittedAt,
      questions: questions
          .map(
            (item) => item is PatientDetailSurveyQuestionModel
                ? item.toEntity()
                : PatientDetailSurveyQuestionEntity(
                    question: item.question,
                    type: item.type,
                    options: item.options,
                    selected: item.selected,
                    rating: item.rating,
                    textAnswer: item.textAnswer,
                  ),
          )
          .toList(),
    );
  }
}
