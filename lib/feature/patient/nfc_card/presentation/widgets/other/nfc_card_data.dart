import 'package:ali_therapy_admin/feature/patient/patient_detail/domain/patient_detail_domain/entities/patient_detail_profile_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_display.dart';

// ============================================================
// NFC CARD DATA
// ------------------------------------------------------------
// Values shown on the patient ID card.
// Uses Full View profile when present; otherwise sample.
// Clinic lines match the doctor-app NFC card.
// ============================================================

class NfcCardData {
  const NfcCardData({
    required this.name,
    required this.patientId,
    required this.phone,
    required this.cnic,
    required this.bloodGroup,
    required this.address,
    required this.cardUrl,
    required this.clinicPhone,
    required this.cardNumber,
    this.photoUrl = '',
  });

  final String name;
  final String patientId;
  final String phone;
  final String cnic;
  final String bloodGroup;
  final String address;
  final String cardUrl;
  final String clinicPhone;
  final String cardNumber;
  final String photoUrl;

  factory NfcCardData.fromProfile(PatientDetailProfileEntity profile) {
    const sample = NfcCardData.sample;
    final name = PatientDetailDisplay.titled(profile.name);
    final id = PatientDetailDisplay.text(profile.id);
    final phone = PatientDetailDisplay.text(profile.phone);
    final cnic = PatientDetailDisplay.text(profile.cnic);
    final blood = PatientDetailDisplay.text(profile.bloodGroup);

    return NfcCardData(
      name: name == PatientDetailDisplay.empty ? sample.name : name,
      patientId: id == PatientDetailDisplay.empty ? sample.patientId : id,
      phone: phone == PatientDetailDisplay.empty ? sample.phone : phone,
      cnic: cnic == PatientDetailDisplay.empty ? sample.cnic : cnic,
      bloodGroup: blood == PatientDetailDisplay.empty ? '—' : blood,
      address: sample.address,
      cardUrl: sample.cardUrl,
      clinicPhone: sample.clinicPhone,
      cardNumber: sample.cardNumber,
    );
  }

  static const NfcCardData sample = NfcCardData(
    name: 'Gul Maqsood',
    patientId: '193100330',
    phone: '0321-7553048',
    cnic: '61101-3998512-4',
    bloodGroup: '—',
    address: 'Pakland & Kiran Plaza F-8, Islamabad, Islamabad',
    cardUrl: 'https://alitherapy.neonweb.tech/',
    clinicPhone: '0516125380',
    cardNumber: '0000000000013933',
  );
}
