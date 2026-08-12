import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_date_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_fields_row.dart';

// ============================================================
// DETAILS FORM FIELDS
// ------------------------------------------------------------
// Personal / employment details for edit employee step 2.
// ============================================================

class DetailsFormFields extends StatefulWidget {
  const DetailsFormFields({super.key});

  @override
  State<DetailsFormFields> createState() => _DetailsFormFieldsState();
}

class _DetailsFormFieldsState extends State<DetailsFormFields> {
  static const _departments = [
    'Physiotherapy',
    'Administration',
    'Reception',
    'Finance',
  ];

  static const _designations = [
    'CEO',
    'Physiotherapist',
    'Manager',
    'Consultant',
  ];

  static const _shifts = [
    'Morning Shift (8AM - 4PM)',
    'Evening Shift (4PM - 12AM)',
    'Night Shift',
  ];

  static const _genders = ['Male', 'Female', 'Other'];

  static const _salaryTypes = ['Fixed', 'Commission', 'Hourly'];

  late final TextEditingController _biometricController;
  late final TextEditingController _phoneController;
  late final TextEditingController _cnicController;
  late final TextEditingController _emergencyNameController;
  late final TextEditingController _emergencyRelationController;
  late final TextEditingController _emergencyPhoneController;
  late final TextEditingController _religionController;
  late final TextEditingController _bloodGroupController;
  late final TextEditingController _districtController;
  late final TextEditingController _experienceController;
  late final TextEditingController _salaryController;
  late final TextEditingController _presentAddressController;
  late final TextEditingController _permanentAddressController;
  late final TextEditingController _biographyController;

  @override
  void initState() {
    super.initState();
    _biometricController = TextEditingController();
    _phoneController = TextEditingController(text: '0332-0233322');
    _cnicController = TextEditingController(text: '16204-0389530-1');
    _emergencyNameController = TextEditingController(text: 'Dr Waqar');
    _emergencyRelationController = TextEditingController(text: 'Brother');
    _emergencyPhoneController = TextEditingController(text: '1231 3214231');
    _religionController = TextEditingController(text: 'Islam');
    _bloodGroupController = TextEditingController(text: 'O+');
    _districtController = TextEditingController();
    _experienceController = TextEditingController();
    _salaryController = TextEditingController(text: '400000.00');
    _presentAddressController = TextEditingController(text: 'F8 Islamabad');
    _permanentAddressController = TextEditingController(text: 'F8 Islamabad');
    _biographyController = TextEditingController();
  }

  @override
  void dispose() {
    _biometricController.dispose();
    _phoneController.dispose();
    _cnicController.dispose();
    _emergencyNameController.dispose();
    _emergencyRelationController.dispose();
    _emergencyPhoneController.dispose();
    _religionController.dispose();
    _bloodGroupController.dispose();
    _districtController.dispose();
    _experienceController.dispose();
    _salaryController.dispose();
    _presentAddressController.dispose();
    _permanentAddressController.dispose();
    _biographyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const EditFieldsRow(
          children: [
            AppDropdownField(
              label: 'Department',
              isRequired: true,
              hintText: 'Select Department',
              items: _departments,
              value: 'Physiotherapy',
            ),
            AppDropdownField(
              label: 'Designation',
              isRequired: true,
              hintText: 'Select Designation',
              items: _designations,
              value: 'CEO',
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            const AppDropdownField(
              label: 'Shift',
              isRequired: true,
              hintText: 'Select Shift',
              items: _shifts,
              value: 'Morning Shift (8AM - 4PM)',
            ),
            AppTextField(
              label: 'Biometric Device User ID',
              hintText: 'Biometric Device User ID..',
              controller: _biometricController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            const AppDropdownField(
              label: 'Gender',
              isRequired: true,
              hintText: 'Select Gender',
              items: _genders,
              value: 'Male',
            ),
            AppTextField(
              label: 'Phone',
              isRequired: true,
              hintText: 'Phone..',
              keyboardType: TextInputType.phone,
              controller: _phoneController,
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
              controller: _cnicController,
            ),
            const EditDateField(
              label: 'Date of Birth',
              isRequired: true,
              value: '04/04/1994',
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            const EditDateField(
              label: 'Joining Date',
              isRequired: true,
              value: '08/02/2021',
            ),
            AppTextField(
              label: 'Emergency Contact Name',
              hintText: 'Name..',
              controller: _emergencyNameController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'Emergency Contact Relationship',
              hintText: 'Relationship..',
              controller: _emergencyRelationController,
            ),
            AppTextField(
              label: 'Emergency Contact',
              hintText: 'Phone..',
              keyboardType: TextInputType.phone,
              controller: _emergencyPhoneController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'Religion',
              hintText: 'Religion..',
              controller: _religionController,
            ),
            AppTextField(
              label: 'Blood Group',
              hintText: 'Blood group..',
              controller: _bloodGroupController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'District',
              hintText: 'District...',
              controller: _districtController,
            ),
            AppTextField(
              label: 'Experience (years)',
              hintText: 'Experience in years..',
              keyboardType: TextInputType.number,
              controller: _experienceController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            const AppDropdownField(
              label: 'Salary Type',
              isRequired: true,
              hintText: 'Select Salary Type',
              items: _salaryTypes,
              value: 'Fixed',
            ),
            AppTextField(
              label: 'Salary Amount',
              isRequired: true,
              hintText: 'Amount..',
              keyboardType: TextInputType.number,
              controller: _salaryController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        AppTextField(
          label: 'Present Address',
          isRequired: true,
          hintText: 'Present address..',
          maxLines: 3,
          controller: _presentAddressController,
        ),
        SizedBox(height: 12.h),
        AppTextField(
          label: 'Permanent Address',
          isRequired: true,
          hintText: 'Permanent address..',
          maxLines: 3,
          controller: _permanentAddressController,
        ),
        SizedBox(height: 12.h),
        AppTextField(
          label: 'Biography',
          hintText: 'Biography..',
          maxLines: 4,
          controller: _biographyController,
        ),
      ],
    );
  }
}
