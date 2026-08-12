import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_question_card.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/survey_visit_card.dart';

// ============================================================
// SURVEY SAMPLES
// ------------------------------------------------------------
// Sample visit feedback data for Survey tab (UI only).
// ============================================================

class SurveySamples {
  SurveySamples._();

  static const _availabilityOptions = ['Yes', 'Mostly', 'No'];
  static const _painOptions = ['Improved', 'Same', 'Worse'];
  static const _yesNoOptions = ['Yes', 'No'];

  static List<SurveyVisitData> get all => const [
        SurveyVisitData(
          visitTitle: 'Visit #9237 Feedback',
          visitDate: 'Aug 06, 2026',
          therapist: 'DR ISLAM BIBI',
          submittedAt: 'Aug 06, 2026 02:14 PM',
          questions: [
            SurveyQuestionData.choice(
              question:
                  'Was the Doctor available throughout your treatment session ?',
              options: _availabilityOptions,
              selected: 'Yes',
            ),
            SurveyQuestionData.choice(
              question: "Pain After Today's physio session.",
              options: _painOptions,
              selected: 'Improved',
            ),
            SurveyQuestionData.choice(
              question:
                  'Did the Doctor use a phone During Your Treatment Session ?',
              options: _yesNoOptions,
              selected: 'No',
            ),
            SurveyQuestionData.stars(
              question: 'Doctor Hygiene',
              rating: 5,
            ),
            SurveyQuestionData.stars(
              question: 'Clinic Environment',
              rating: 5,
            ),
            SurveyQuestionData.stars(
              question: 'Reception Experience',
              rating: 5,
            ),
            SurveyQuestionData.text(
              question: 'Any suggestions to improve our services ?',
              textAnswer: 'satisfied',
            ),
          ],
        ),
        SurveyVisitData(
          visitTitle: 'Visit #9049 Feedback',
          visitDate: 'Aug 05, 2026',
          therapist: 'DR ISLAM BIBI',
          submittedAt: 'Aug 05, 2026 01:37 PM',
          questions: [
            SurveyQuestionData.stars(
              question: 'Reception Experience',
              rating: 5,
            ),
            SurveyQuestionData.stars(
              question: 'Clinic Environment',
              rating: 5,
            ),
            SurveyQuestionData.stars(
              question: 'Doctor Hygiene',
              rating: 5,
            ),
            SurveyQuestionData.choice(
              question:
                  'Did the Doctor use a phone During Your Treatment Session ?',
              options: _yesNoOptions,
              selected: 'No',
            ),
            SurveyQuestionData.choice(
              question:
                  'Was the Doctor available throughout your treatment session ?',
              options: _availabilityOptions,
              selected: 'Yes',
            ),
            SurveyQuestionData.choice(
              question: "Pain After Today's physio session.",
              options: _painOptions,
              selected: 'Improved',
            ),
          ],
        ),
        SurveyVisitData(
          visitTitle: 'Visit #8908 Feedback',
          visitDate: 'Aug 04, 2026',
          therapist: 'DR ISLAM BIBI',
          submittedAt: 'Aug 04, 2026 01:45 PM',
          questions: [
            SurveyQuestionData.text(
              question: 'Any suggestions to improve our services ?',
              textAnswer: 'Satisfied',
            ),
            SurveyQuestionData.stars(
              question: 'Reception Experience',
              rating: 5,
            ),
            SurveyQuestionData.stars(
              question: 'Clinic Environment',
              rating: 5,
            ),
            SurveyQuestionData.stars(
              question: 'Doctor Hygiene',
              rating: 5,
            ),
            SurveyQuestionData.choice(
              question:
                  'Did the Doctor use a phone During Your Treatment Session ?',
              options: _yesNoOptions,
              selected: 'No',
            ),
            SurveyQuestionData.choice(
              question:
                  'Was the Doctor available throughout your treatment session ?',
              options: _availabilityOptions,
              selected: 'Yes',
            ),
            SurveyQuestionData.choice(
              question: "Pain After Today's physio session.",
              options: _painOptions,
              selected: 'Improved',
            ),
          ],
        ),
      ];
}
