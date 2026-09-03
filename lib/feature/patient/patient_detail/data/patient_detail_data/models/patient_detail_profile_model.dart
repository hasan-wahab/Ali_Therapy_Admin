import '../../../domain/patient_detail_domain/entities/patient_detail_profile_entity.dart';
import 'patient_detail_json_helpers.dart';

// ============================================================
// PATIENT DETAIL PROFILE MODEL
// ------------------------------------------------------------
// Parses data.profile
// ============================================================

class PatientDetailProfileModel extends PatientDetailProfileEntity {
  const PatientDetailProfileModel({
    super.id,
    super.name,
    super.email,
    super.phone,
    super.cnic,
    super.dateOfBirth,
    super.age,
    super.gender,
    super.bloodGroup,
    super.insurance,
    super.referredBy,
    super.lastVisitAt,
    super.totalVisits,
    super.activePackages,
    super.totalSpent,
    super.therapySessions,
  });

  factory PatientDetailProfileModel.fromJson(Map<String, dynamic> json) {
    return PatientDetailProfileModel(
      id: PatientDetailJsonHelpers.text(json['id']),
      name: PatientDetailJsonHelpers.text(json['name']),
      email: PatientDetailJsonHelpers.text(json['email']),
      phone: PatientDetailJsonHelpers.text(json['phone']),
      cnic: PatientDetailJsonHelpers.text(json['cnic']),
      dateOfBirth: PatientDetailJsonHelpers.text(json['date_of_birth']),
      age: PatientDetailJsonHelpers.integer(json['age']),
      gender: PatientDetailJsonHelpers.text(json['gender']),
      bloodGroup: PatientDetailJsonHelpers.text(json['blood_group']),
      insurance: PatientDetailJsonHelpers.text(json['insurance']),
      referredBy: PatientDetailJsonHelpers.text(json['referred_by']),
      lastVisitAt: PatientDetailJsonHelpers.text(json['last_visit_at']),
      totalVisits: PatientDetailJsonHelpers.integer(json['total_visits']),
      activePackages: PatientDetailJsonHelpers.integer(json['active_packages']),
      totalSpent: PatientDetailJsonHelpers.decimal(json['total_spent']),
      therapySessions: PatientDetailJsonHelpers.integer(json['therapy_sessions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'cnic': cnic,
      'date_of_birth': dateOfBirth,
      'age': age,
      'gender': gender,
      'blood_group': bloodGroup,
      'insurance': insurance,
      'referred_by': referredBy,
      'last_visit_at': lastVisitAt,
      'total_visits': totalVisits,
      'active_packages': activePackages,
      'total_spent': totalSpent,
      'therapy_sessions': therapySessions,
    };
  }

  PatientDetailProfileEntity toEntity() {
    return PatientDetailProfileEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      cnic: cnic,
      dateOfBirth: dateOfBirth,
      age: age,
      gender: gender,
      bloodGroup: bloodGroup,
      insurance: insurance,
      referredBy: referredBy,
      lastVisitAt: lastVisitAt,
      totalVisits: totalVisits,
      activePackages: activePackages,
      totalSpent: totalSpent,
      therapySessions: therapySessions,
    );
  }
}
