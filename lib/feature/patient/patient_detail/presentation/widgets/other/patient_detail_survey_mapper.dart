import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_survey_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_question_card.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_visit_card.dart';

// ============================================================
// PATIENT DETAIL SURVEY MAPPER
// ------------------------------------------------------------
// Maps Full View surveys[] → Survey tab widgets.
// ============================================================

class PatientDetailSurveyMapper {
  PatientDetailSurveyMapper._();

  static SurveyVisitData visit(PatientDetailSurveyEntity survey) {
    return SurveyVisitData(
      visitTitle: _visitTitle(survey),
      visitDate: PatientDetailDisplay.date(survey.visitDate),
      therapist: PatientDetailDisplay.text(survey.therapist),
      submittedAt: PatientDetailDisplay.dateTime(survey.submittedAt),
      questions: survey.questions.map(question).toList(),
    );
  }

  static String _visitTitle(PatientDetailSurveyEntity survey) {
    final titled = PatientDetailDisplay.text(survey.visitTitle);
    if (titled != PatientDetailDisplay.empty) return titled;
    if (survey.visitNumber > 0) {
      return 'Visit #${survey.visitNumber} Feedback';
    }
    final id = PatientDetailDisplay.hashedId(survey.visitId);
    if (id == PatientDetailDisplay.empty) {
      return 'Visit ${PatientDetailDisplay.empty} Feedback';
    }
    return 'Visit $id Feedback';
  }

  static SurveyQuestionData question(
    PatientDetailSurveyQuestionEntity item,
  ) {
    final type = item.type.trim().toLowerCase();
    final questionText = PatientDetailDisplay.text(item.question);

    if (type == 'stars' || type == 'star' || type == 'rating') {
      return SurveyQuestionData.stars(
        question: questionText,
        rating: item.rating,
      );
    }
    if (type == 'text' || type == 'comment') {
      return SurveyQuestionData.text(
        question: questionText,
        textAnswer: PatientDetailDisplay.text(item.textAnswer),
      );
    }
    if (type == 'choice' ||
        type == 'select' ||
        item.options.isNotEmpty) {
      return SurveyQuestionData.choice(
        question: questionText,
        options: item.options,
        selected: PatientDetailDisplay.text(item.selected),
      );
    }
    if (item.rating > 0) {
      return SurveyQuestionData.stars(
        question: questionText,
        rating: item.rating,
      );
    }
    return SurveyQuestionData.text(
      question: questionText,
      textAnswer: PatientDetailDisplay.text(
        item.textAnswer.isNotEmpty ? item.textAnswer : item.selected,
      ),
    );
  }
}
