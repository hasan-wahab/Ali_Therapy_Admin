import 'package:flutter/material.dart';

import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/user_details/user_details_form_fields.dart';

// ============================================================
// USER DETAILS SECTION
// ------------------------------------------------------------
// First edit step: login & profile fields (no card wrapper).
// ============================================================

class UserDetailsSection extends StatelessWidget {
  const UserDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserDetailsFormFields();
  }
}
