import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/services/image_picker_service.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_allow_login_group.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_clinic_rooms.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_fields_row.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_profile_picture_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_role_field.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// USER DETAILS FORM FIELDS
// ------------------------------------------------------------
// Login & profile fields for employee edit (mobile).
// ============================================================

class UserDetailsFormFields extends StatelessWidget {
  const UserDetailsFormFields({
    super.key,
    required this.form,
    required this.options,
  });

  final EditEmployeeFormControllers form;
  final EditEmployeeOptionsEntity options;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: form,
      builder: (context, _) {
        final clinicSelected = form.clinicName.isNotEmpty;
        final roomValue = EditClinicRooms.canonical(
          form.clinicName,
          form.roomName,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EditFieldsRow(
              children: [
                AppTextField(
                  label: 'Full Name',
                  isRequired: true,
                  hintText: 'Full name..',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  controller: form.name,
                  hasError: form.isInvalid(EditEmployeeFormControllers.nameKey),
                ),
                AppTextField(
                  label: 'User name (Employee ID)',
                  hintText: 'Employee ID..',
                  keyboardType: TextInputType.text,
                  controller: form.employeeCode,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            AppTextField(
              label: 'Email',
              isRequired: true,
              hintText: 'Email..',
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              controller: form.email,
              hasError: form.isInvalid(EditEmployeeFormControllers.emailKey),
            ),
            SizedBox(height: 12.h),
            AppTextField(
              label: 'Change Password (Optional)',
              hintText: 'Password',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: form.password,
              hasError: form.isInvalid(EditEmployeeFormControllers.passwordKey),
            ),
            SizedBox(height: 12.h),
            EditFieldsRow(
              children: [
                AppDropdownField(
                  label: 'Clinic',
                  hintText: 'Select Clinic',
                  items: options.clinicNames(current: form.clinicName),
                  value: form.clinicName.isEmpty ? null : form.clinicName,
                  onChanged: (value) =>
                      form.setClinic(value, options.idForClinic(value)),
                ),
                AppDropdownField(
                  label: 'Room',
                  hintText: clinicSelected
                      ? 'Select Room'
                      : 'Select clinic first',
                  enabled: clinicSelected,
                  items: EditClinicRooms.roomsFor(
                    form.clinicName,
                    current: form.roomName,
                  ),
                  value: roomValue.isEmpty ? null : roomValue,
                  onChanged: (value) =>
                      form.setRoom(value, options.idForRoom(value)),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            EditRoleField(
              options: options.roleNames(),
              selected: form.roleNames,
              onAdd: (name) => form.addRole(name, options.idForRole(name)),
              onRemove: (name) =>
                  form.removeRole(name, options.idForRole(name)),
            ),
            SizedBox(height: 12.h),
            EditProfilePictureField(
              imageUrl: form.imageUrl.isEmpty ? null : form.imageUrl,
              localBytes: form.profilePictureBytes,
              fileName: form.profilePictureName,
              onChooseFile: () => _pickProfilePicture(context, form),
            ),
            SizedBox(height: 12.h),
            EditAllowLoginGroup(
              value: form.allowLogin ? 'Yes' : 'No',
              onChanged: form.setAllowLogin,
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickProfilePicture(
    BuildContext context,
    EditEmployeeFormControllers form,
  ) async {
    try {
      final file = await sl<ImagePickerService>().pickFromGallery();
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) return;
      form.setProfilePicture(
        path: file.path,
        name: file.name,
        bytes: bytes,
      );
    } catch (_) {
      if (!context.mounted) return;
      AppSnackbar.error(
        context,
        'Could not pick image. Please try again.',
      );
    }
  }
}
