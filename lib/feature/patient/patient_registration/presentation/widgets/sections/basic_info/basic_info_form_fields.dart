import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_input_formatters.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_date_field.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_fields_row.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_registration_form_controllers.dart';

// ============================================================
// BASIC INFO FORM FIELDS
// ------------------------------------------------------------
// Compact layout so step 1 fits on a phone screen.
// City / Gender lists come from GET patients/form-data.
// ============================================================

class BasicInfoFormFields extends StatelessWidget {
  const BasicInfoFormFields({
    super.key,
    required this.form,
    required this.formData,
  });

  final PatientRegistrationFormControllers form;
  final PatientFormDataEntity formData;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PatientFieldsRow(
              children: [
                AppTextField(
                  label: 'Name',
                  isRequired: true,
                  hintText: 'Patient name..',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  controller: form.name,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.nameKey,
                  ),
                ),
                AppTextField(
                  label: 'Father Name',
                  isRequired: true,
                  hintText: 'Father / Husband..',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  controller: form.fatherHusbandName,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.fatherNameKey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            AppTextField(
              label: 'Email',
              isRequired: true,
              hintText: 'Patient email..',
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              controller: form.email,
              hasError: form.isInvalid(
                PatientRegistrationFormControllers.emailKey,
              ),
            ),
            SizedBox(height: 10.h),
            PatientFieldsRow(
              children: [
                AppTextField(
                  label: 'Phone',
                  isRequired: true,
                  hintText: '03XXXXXXXXX',
                  keyboardType: TextInputType.phone,
                  controller: form.phone,
                  inputFormatters: AppInputFormatters.phone,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.phoneKey,
                  ),
                ),
                AppTextField(
                  label: 'Passport',
                  hintText: 'AA1234567',
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  controller: form.passportNo,
                  inputFormatters: AppInputFormatters.passport,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.passportKey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            PatientFieldsRow(
              children: [
                AppTextField(
                  label: 'CNIC',
                  hintText: '12345-1234567-1',
                  keyboardType: TextInputType.number,
                  controller: form.cnic,
                  inputFormatters: AppInputFormatters.cnic,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.cnicKey,
                  ),
                ),
                AppDropdownField(
                  label: 'Gender',
                  isRequired: true,
                  hintText: 'Select Gender',
                  items: formData.genders,
                  value: form.gender.isEmpty ? null : form.gender,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.genderKey,
                  ),
                  onChanged: form.setGender,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            PatientFieldsRow(
              children: [
                PatientDateField(
                  label: 'Birth Date',
                  isRequired: true,
                  value: form.birthDate.isEmpty ? null : form.birthDate,
                  onChanged: form.setBirthDate,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.birthDateKey,
                  ),
                ),
                AppTextField(
                  label: 'Age',
                  hintText: 'Age..',
                  keyboardType: TextInputType.number,
                  controller: form.age,
                  inputFormatters: AppInputFormatters.age,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            AppDropdownField(
              label: 'City',
              isRequired: true,
              hintText: 'Select City',
              items: formData.cities,
              value: form.city.isEmpty ? null : form.city,
              hasError: form.isInvalid(
                PatientRegistrationFormControllers.cityKey,
              ),
              onChanged: form.setCity,
            ),
            if (PatientRegistrationFormControllers.isOtherValue(form.city)) ...[
              SizedBox(height: 10.h),
              AppTextField(
                label: 'Other City',
                isRequired: true,
                hintText: 'Enter city..',
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                controller: form.cityOther,
                hasError: form.isInvalid(
                  PatientRegistrationFormControllers.cityOtherKey,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
