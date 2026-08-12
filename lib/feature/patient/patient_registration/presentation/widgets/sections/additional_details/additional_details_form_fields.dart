import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_fields_row.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_radio_group.dart';

// ============================================================
// ADDITIONAL DETAILS FORM FIELDS
// ------------------------------------------------------------
// Step 2 — referral, medical and status fields (UI only).
// ============================================================

class AdditionalDetailsFormFields extends StatelessWidget {
  const AdditionalDetailsFormFields({super.key});

  static const _referralTypes = [
    'Doctor',
    'Hospital',
    'Friend / Family',
    'Social Media',
    'Walk-in',
    'Other',
  ];

  static const _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  static const _languages = [
    'Urdu',
    'English',
    'Punjabi',
    'Sindhi',
    'Pashto',
    'Balochi',
  ];

  static const _statuses = ['Active', 'Inactive', 'Pending'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PatientFieldsRow(
          children: [
            AppDropdownField(
              label: 'Refer By (Type)',
              isRequired: true,
              hintText: 'Select Referral Type',
              items: _referralTypes,
            ),
            AppTextField(
              label: 'Emergency Contact Phone',
              hintText: 'Contact phone..',
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        SizedBox(height: 14.h),
        const AppDropdownField(
          label: 'Blood Group',
          hintText: 'Select Blood Group',
          items: _bloodGroups,
        ),
        SizedBox(height: 14.h),
        const AppDropdownField(
          label: 'Languages',
          isRequired: true,
          hintText: 'Select Option',
          items: _languages,
        ),
        SizedBox(height: 14.h),
        const PatientRadioGroup(
          label: 'Marital Status',
          isRequired: true,
          options: ['Single', 'Married', 'Divorced'],
          initialValue: 'Single',
        ),
        SizedBox(height: 14.h),
        const AppDropdownField(
          label: 'Status',
          isRequired: true,
          hintText: 'Select Status',
          items: _statuses,
          value: 'Active',
        ),
      ],
    );
  }
}
