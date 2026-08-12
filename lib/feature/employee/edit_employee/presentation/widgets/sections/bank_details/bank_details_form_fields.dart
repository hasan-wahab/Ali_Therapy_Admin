import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_fields_row.dart';

// ============================================================
// BANK DETAILS FORM FIELDS
// ------------------------------------------------------------
// Payroll account fields for edit employee step.
// ============================================================

class BankDetailsFormFields extends StatefulWidget {
  const BankDetailsFormFields({super.key});

  @override
  State<BankDetailsFormFields> createState() => _BankDetailsFormFieldsState();
}

class _BankDetailsFormFieldsState extends State<BankDetailsFormFields> {
  late final TextEditingController _bankNameController;
  late final TextEditingController _branchController;
  late final TextEditingController _branchCodeController;
  late final TextEditingController _accountHolderController;
  late final TextEditingController _accountNumberController;
  late final TextEditingController _ibanController;

  @override
  void initState() {
    super.initState();
    _bankNameController = TextEditingController();
    _branchController = TextEditingController();
    _branchCodeController = TextEditingController();
    _accountHolderController = TextEditingController();
    _accountNumberController = TextEditingController();
    _ibanController = TextEditingController();
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _branchController.dispose();
    _branchCodeController.dispose();
    _accountHolderController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

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
              controller: _bankNameController,
            ),
            AppTextField(
              label: 'Branch',
              hintText: 'Branch',
              controller: _branchController,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        EditFieldsRow(
          children: [
            AppTextField(
              label: 'Branch Code',
              hintText: 'Branch Code',
              controller: _branchCodeController,
            ),
            AppTextField(
              label: 'Account Holder',
              hintText: 'Account Holder',
              controller: _accountHolderController,
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
              controller: _accountNumberController,
            ),
            AppTextField(
              label: 'IBAN',
              hintText: 'IBAN',
              controller: _ibanController,
            ),
          ],
        ),
      ],
    );
  }
}
