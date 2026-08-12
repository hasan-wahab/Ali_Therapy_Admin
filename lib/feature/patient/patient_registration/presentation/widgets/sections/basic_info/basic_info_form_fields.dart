import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_date_field.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_fields_row.dart';

// ============================================================
// BASIC INFO FORM FIELDS
// ------------------------------------------------------------
// Compact layout so step 1 fits on a phone screen.
// ============================================================

class BasicInfoFormFields extends StatelessWidget {
  const BasicInfoFormFields({super.key});

  static const _genders = ['Male', 'Female', 'Other'];
  static const _cities = [
    'Lahore',
    'Karachi',
    'Islamabad',
    'Rawalpindi',
    'Faisalabad',
    'Multan',
    'Peshawar',
    'Quetta',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Name + Father Name
        const PatientFieldsRow(
          children: [
            AppTextField(
              label: 'Name',
              isRequired: true,
              hintText: 'Patient name..',
            ),
            AppTextField(
              label: 'Father Name',
              isRequired: true,
              hintText: 'Father / Husband..',
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Email (full width)
        const AppTextField(
          label: 'Email',
          isRequired: true,
          hintText: 'Patient email..',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 10.h),

        // Phone + Passport
        const PatientFieldsRow(
          children: [
            AppTextField(
              label: 'Phone',
              isRequired: true,
              hintText: 'Phone..',
              keyboardType: TextInputType.phone,
            ),
            AppTextField(
              label: 'Passport',
              hintText: 'Passport number..',
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // CNIC + Gender
        const PatientFieldsRow(
          children: [
            AppTextField(
              label: 'CNIC',
              hintText: 'CNIC..',
              keyboardType: TextInputType.number,
            ),
            AppDropdownField(
              label: 'Gender',
              isRequired: true,
              hintText: 'Select Gender',
              items: _genders,
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // Birth Date + Age
        const PatientFieldsRow(
          children: [
            PatientDateField(
              label: 'Birth Date',
              isRequired: true,
            ),
            AppTextField(
              label: 'Age',
              hintText: 'Age..',
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // City (full width)
        const AppDropdownField(
          label: 'City',
          isRequired: true,
          hintText: 'Select City',
          items: _cities,
        ),
      ],
    );
  }
}
