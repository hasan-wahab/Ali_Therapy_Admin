import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_fields_row.dart';

// ============================================================
// BANK DETAILS FORM FIELDS
// ------------------------------------------------------------
// Payroll account fields for edit employee step.
// ============================================================

class BankDetailsFormFields extends StatelessWidget {
  const BankDetailsFormFields({
    super.key,
    required this.form,
  });

  final EditEmployeeFormControllers form;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'Bank Name',
              hintText: 'Bank Name',
              controller: form.bankName,
            ),
            AppTextField(
              label: 'Branch',
              hintText: 'Branch',
              controller: form.branch,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'Branch Code',
              hintText: 'Branch Code',
              controller: form.branchCode,
            ),
            AppTextField(
              label: 'Account Holder',
              hintText: 'Account Holder',
              controller: form.accountHolder,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'Account Number',
              hintText: 'Account Number',
              keyboardType: TextInputType.number,
              controller: form.accountNumber,
            ),
            AppTextField(
              label: 'IBAN',
              hintText: 'IBAN',
              controller: form.iban,
            ),
          ],
        ),
      ],
    );
  }
}
