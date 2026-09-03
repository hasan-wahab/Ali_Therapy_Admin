import 'package:equatable/equatable.dart';

// ============================================================
// PATIENT DETAIL PROFILE (Domain)
// ------------------------------------------------------------
// API: data.profile
// ============================================================

class PatientDetailProfileEntity extends Equatable {
  const PatientDetailProfileEntity({
    this.id = '',
    this.name = '',
    this.email = '',
    this.phone = '',
    this.cnic = '',
    this.dateOfBirth = '',
    this.age = 0,
    this.gender = '',
    this.bloodGroup = '',
    this.insurance = '',
    this.referredBy = '',
    this.lastVisitAt = '',
    this.totalVisits = 0,
    this.activePackages = 0,
    this.totalSpent = 0,
    this.therapySessions = 0,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String cnic;
  final String dateOfBirth;
  final int age;
  final String gender;
  final String bloodGroup;
  final String insurance;
  final String referredBy;
  final String lastVisitAt;
  final int totalVisits;
  final int activePackages;
  final double totalSpent;
  final int therapySessions;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        cnic,
        dateOfBirth,
        age,
        gender,
        bloodGroup,
        insurance,
        referredBy,
        lastVisitAt,
        totalVisits,
        activePackages,
        totalSpent,
        therapySessions,
      ];
}
