import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_input_formatters.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_fields_row.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_radio_group.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_registration_form_controllers.dart';

// ============================================================
// ADDITIONAL DETAILS FORM FIELDS
// ------------------------------------------------------------
// Step 2 — referral and medical fields from GET patients/form-data.
// ============================================================

class AdditionalDetailsFormFields extends StatelessWidget {
  const AdditionalDetailsFormFields({
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
        final referral = formData.referralTypeForLabel(form.referByLabel);
        final maritalOptions = formData.maritalStatuses;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PatientFieldsRow(
              children: [
                AppDropdownField(
                  label: 'Refer By (Type)',
                  isRequired: true,
                  hintText: 'Select Referral Type',
                  items: formData.referralLabels,
                  value: form.referByLabel.isEmpty ? null : form.referByLabel,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.referByKey,
                  ),
                  onChanged: form.setReferByLabel,
                ),
                AppTextField(
                  label: 'Emergency Contact Phone',
                  hintText: '03XXXXXXXXX',
                  keyboardType: TextInputType.phone,
                  controller: form.emergencyContactPhone,
                  inputFormatters: AppInputFormatters.phone,
                  hasError: form.isInvalid(
                    PatientRegistrationFormControllers.emergencyPhoneKey,
                  ),
                ),
              ],
            ),
            if (referral != null && referral.needsField) ...[
              SizedBox(height: 14.h),
              AppDropdownField(
                label: 'Referral Field',
                hintText: 'Select Option',
                items: formData.referralFields,
                value: form.referralField.isEmpty ? null : form.referralField,
                hasError: form.isInvalid(
                  PatientRegistrationFormControllers.referralFieldKey,
                ),
                onChanged: form.setReferralField,
              ),
            ],
            if (referral != null && referral.needsPanel) ...[
              SizedBox(height: 14.h),
              AppDropdownField(
                label: 'Insurance Panel',
                hintText: 'Select Panel',
                items: formData.insurancePanels,
                value:
                    form.insurancePanel.isEmpty ? null : form.insurancePanel,
                hasError: form.isInvalid(
                  PatientRegistrationFormControllers.insurancePanelKey,
                ),
                onChanged: form.setInsurancePanel,
              ),
            ],
            if (referral != null && referral.needsSocial) ...[
              SizedBox(height: 14.h),
              AppDropdownField(
                label: 'Social Media',
                hintText: 'Select Platform',
                items: formData.socialMediaPlatforms,
                value: form.socialMedia.isEmpty ? null : form.socialMedia,
                hasError: form.isInvalid(
                  PatientRegistrationFormControllers.socialMediaKey,
                ),
                onChanged: form.setSocialMedia,
              ),
            ],
            if (referral != null && referral.needsText) ...[
              SizedBox(height: 14.h),
              AppTextField(
                label: 'Other Referral',
                hintText: 'Enter referral..',
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: form.otherReferral,
                hasError: form.isInvalid(
                  PatientRegistrationFormControllers.otherReferralKey,
                ),
              ),
            ],
            SizedBox(height: 14.h),
            AppDropdownField(
              label: 'Blood Group',
              hintText: 'Select Blood Group',
              items: formData.bloodGroups,
              value: form.bloodGroup.isEmpty ? null : form.bloodGroup,
              onChanged: form.setBloodGroup,
            ),
            SizedBox(height: 14.h),
            AppDropdownField(
              label: 'Languages',
              isRequired: true,
              hintText: 'Select Option',
              items: formData.languages,
              value: form.language.isEmpty ? null : form.language,
              hasError: form.isInvalid(
                PatientRegistrationFormControllers.languageKey,
              ),
              onChanged: form.setLanguage,
            ),
            if (PatientRegistrationFormControllers.isOtherValue(
              form.language,
            )) ...[
              SizedBox(height: 14.h),
              AppTextField(
                label: 'Other Language',
                isRequired: true,
                hintText: 'Enter language..',
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                controller: form.languagesOther,
                hasError: form.isInvalid(
                  PatientRegistrationFormControllers.languagesOtherKey,
                ),
              ),
            ],
            SizedBox(height: 14.h),
            PatientRadioGroup(
              label: 'Marital Status',
              isRequired: true,
              options: maritalOptions,
              value: form.maritalStatus.isEmpty ? null : form.maritalStatus,
              onChanged: form.setMaritalStatus,
            ),
          ],
        );
      },
    );
  }
}
