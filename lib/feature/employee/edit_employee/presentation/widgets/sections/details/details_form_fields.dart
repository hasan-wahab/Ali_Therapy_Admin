import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_constants.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_date_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_fields_row.dart';

// ============================================================
// DETAILS FORM FIELDS
// ------------------------------------------------------------
// Personal / employment details for edit employee step 2.
// ============================================================

class DetailsFormFields extends StatelessWidget {
  const DetailsFormFields({
    super.key,
    required this.form,
    required this.options,
  });

  final EditEmployeeFormControllers form;
  final EditEmployeeOptionsEntity options;

  static const _genders = ['Male', 'Female'];
  static const _salaryTypes = ['Fixed', 'Commission'];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EditFieldsRow(
              children: [
                AppDropdownField(
                  label: 'Department',
                  isRequired: true,
                  hintText: 'Select Department',
                  items: options.departmentNames(current: form.departmentName),
                  value:
                      form.departmentName.isEmpty ? null : form.departmentName,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.departmentKey,
                  ),
                  onChanged: (value) => form.setDepartment(
                    value,
                    options.idForDepartment(value),
                  ),
                ),
                AppDropdownField(
                  label: 'Designation',
                  isRequired: true,
                  hintText: 'Select Designation',
                  items:
                      options.designationNames(current: form.designationName),
                  value: form.designationName.isEmpty
                      ? null
                      : form.designationName,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.designationKey,
                  ),
                  onChanged: (value) => form.setDesignation(
                    value,
                    options.idForDesignation(value),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppDropdownField(
                  label: 'Shift',
                  hintText: 'Select Shift',
                  items: options.shiftNames(current: form.shiftName),
                  value: form.shiftName.isEmpty ? null : form.shiftName,
                  onChanged: (value) =>
                      form.setShift(value, options.idForShift(value)),
                ),
                AppTextField(
                  label: 'Biometric Device User ID',
                  hintText: 'Biometric Device User ID..',
                  controller: form.biometricId,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppDropdownField(
                  label: 'Gender',
                  isRequired: true,
                  hintText: 'Select Gender',
                  items: _withCurrent(_genders, form.gender),
                  value: form.gender.isEmpty ? null : form.gender,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.genderKey,
                  ),
                  onChanged: form.setGender,
                ),
                AppTextField(
                  label: 'Phone',
                  isRequired: true,
                  hintText: 'Phone..',
                  keyboardType: TextInputType.phone,
                  controller: form.phone,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.phoneKey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppTextField(
                  label: 'CNIC',
                  isRequired: true,
                  hintText: 'CNIC..',
                  keyboardType: TextInputType.number,
                  controller: form.cnic,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.cnicKey,
                  ),
                ),
                EditDateField(
                  label: 'Date of Birth',
                  isRequired: true,
                  value: form.dateOfBirth,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.dateOfBirthKey,
                  ),
                  onChanged: form.setDateOfBirth,
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                EditDateField(
                  label: 'Joining Date',
                  isRequired: true,
                  value: form.joiningDate,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.joiningDateKey,
                  ),
                  onChanged: form.setJoiningDate,
                ),
                AppTextField(
                  label: 'Emergency Contact Name',
                  isRequired: true,
                  hintText: 'Name..',
                  controller: form.emergencyName,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.emergencyNameKey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppTextField(
                  label: 'Emergency Contact Relationship',
                  isRequired: true,
                  hintText: 'Relationship..',
                  controller: form.emergencyRelationship,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.emergencyRelationshipKey,
                  ),
                ),
                AppTextField(
                  label: 'Emergency Contact',
                  isRequired: true,
                  hintText: 'Phone..',
                  keyboardType: TextInputType.phone,
                  controller: form.emergencyPhone,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.emergencyPhoneKey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppTextField(
                  label: 'Religion',
                  isRequired: true,
                  hintText: 'Religion..',
                  controller: form.religion,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.religionKey,
                  ),
                ),
                AppDropdownField(
                  label: 'Blood Group',
                  isRequired: true,
                  hintText: 'Select Blood Group',
                  items: _withCurrent(
                    AppConstants.bloodGroups,
                    form.bloodGroup,
                  ),
                  value: form.bloodGroup.isEmpty ? null : form.bloodGroup,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.bloodGroupKey,
                  ),
                  onChanged: form.setBloodGroup,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppTextField(
                  label: 'District',
                  hintText: 'District...',
                  controller: form.district,
                ),
                AppTextField(
                  label: 'Experience (years)',
                  hintText: 'Experience in years..',
                  keyboardType: TextInputType.number,
                  controller: form.experienceYears,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppDropdownField(
                  label: 'Salary Type',
                  isRequired: true,
                  hintText: 'Select Salary Type',
                  items: _withCurrent(_salaryTypes, form.salaryType),
                  value: form.salaryType.isEmpty ? null : form.salaryType,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.salaryTypeKey,
                  ),
                  onChanged: form.setSalaryType,
                ),
                AppTextField(
                  label: 'Salary Amount',
                  isRequired: true,
                  hintText: 'Amount..',
                  keyboardType: TextInputType.number,
                  controller: form.salary,
                  hasError: form.isInvalid(
                    EditEmployeeFormControllers.salaryKey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            AppTextField(
              label: 'Present Address',
              isRequired: true,
              hintText: 'Present address..',
              maxLines: 3,
              controller: form.presentAddress,
              hasError: form.isInvalid(
                EditEmployeeFormControllers.presentAddressKey,
              ),
            ),
            SizedBox(height: 12.h),
            AppTextField(
              label: 'Permanent Address',
              isRequired: true,
              hintText: 'Permanent address..',
              maxLines: 3,
              controller: form.permanentAddress,
              hasError: form.isInvalid(
                EditEmployeeFormControllers.permanentAddressKey,
              ),
            ),
            SizedBox(height: 12.h),
            AppTextField(
              label: 'Biography',
              hintText: 'Biography..',
              maxLines: 4,
              controller: form.biography,
            ),
          ],
        );
      },
    );
  }

  List<String> _withCurrent(List<String> items, String current) {
    if (current.isNotEmpty && !items.contains(current)) {
      return [current, ...items];
    }
    return items;
  }
}
