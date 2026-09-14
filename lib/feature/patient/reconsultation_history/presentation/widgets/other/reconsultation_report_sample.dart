// ============================================================
// RECONSULTATION REPORT SAMPLE
// ------------------------------------------------------------
// UI-first sample for View Report. No logo / clinic branding.
// ============================================================

class ReconsultationReportQuestion {
  const ReconsultationReportQuestion({
    required this.number,
    required this.question,
    required this.answer,
  });

  final int number;
  final String question;
  final String answer;
}

class ReconsultationReportAssessment {
  const ReconsultationReportAssessment({
    required this.number,
    required this.label,
    required this.value,
  });

  final int number;
  final String label;
  final String value;
}

class ReconsultationReportSample {
  const ReconsultationReportSample({
    required this.date,
    required this.clinic,
    required this.patientName,
    required this.cnic,
    required this.ageGender,
    required this.consultant,
    required this.scenario,
    required this.questions,
    required this.complaint,
    required this.recoveryScore,
    required this.recoveryMax,
    required this.assessments,
  });

  final String date;
  final String clinic;
  final String patientName;
  final String cnic;
  final String ageGender;
  final String consultant;
  final String scenario;
  final List<ReconsultationReportQuestion> questions;
  final String complaint;
  final int recoveryScore;
  final int recoveryMax;
  final List<ReconsultationReportAssessment> assessments;
}

const ReconsultationReportSample reconsultationReportSample =
    ReconsultationReportSample(
  date: '01 May, 2026',
  clinic: 'Clinic 1, Kirenizer, near IDC, F-8, Islamabad',
  patientName: 'Gul Maqsood',
  cnic: '61101-3998512-4',
  ageGender: '63 / Female',
  consultant: 'DR BILAL AHMED, Clinic 1',
  scenario: '',
  questions: [
    ReconsultationReportQuestion(
      number: 1,
      question: 'Treatment follow?',
      answer: 'Yes',
    ),
    ReconsultationReportQuestion(
      number: 2,
      question: 'Assigned therapist is giving you sessions?',
      answer: 'Yes',
    ),
    ReconsultationReportQuestion(
      number: 3,
      question: 'Full attention?',
      answer: 'Yes',
    ),
    ReconsultationReportQuestion(
      number: 4,
      question: 'Irrelevant talk?',
      answer: 'No',
    ),
    ReconsultationReportQuestion(
      number: 5,
      question: 'Went outside room?',
      answer: 'No',
    ),
    ReconsultationReportQuestion(
      number: 6,
      question: 'Therapist hygiene?',
      answer: 'Yes',
    ),
    ReconsultationReportQuestion(
      number: 7,
      question: 'Phone use?',
      answer: 'No',
    ),
  ],
  complaint: 'No complaints reported by the patient.',
  recoveryScore: 2,
  recoveryMax: 10,
  assessments: [
    ReconsultationReportAssessment(
      number: 1,
      label: 'Hygiene',
      value: 'Good',
    ),
    ReconsultationReportAssessment(
      number: 2,
      label: 'Behavior',
      value: 'Cooperative',
    ),
    ReconsultationReportAssessment(
      number: 3,
      label: 'Genuinely in pain',
      value: 'N/A',
    ),
    ReconsultationReportAssessment(
      number: 4,
      label: 'Psychological pain / stress',
      value: 'N/A',
    ),
    ReconsultationReportAssessment(
      number: 6,
      label: 'Affordability status',
      value: 'N/A',
    ),
  ],
);
