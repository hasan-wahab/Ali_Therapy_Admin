import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patient_card_list.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_search_filter_section.dart';

// ============================================================
// ALL PATIENTS PAGE
// ------------------------------------------------------------
// Search + filter row fixed on top; patient cards scroll below.
// Same pattern as All Employees.
// ============================================================

class AllPatientsPage extends StatefulWidget {
  const AllPatientsPage({super.key});

  @override
  State<AllPatientsPage> createState() => _AllPatientsPageState();
}

class _AllPatientsPageState extends State<AllPatientsPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 12.w;

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 10.h),
          child: PatientsSearchFilterSection(
            searchQuery: _searchQuery,
            searchMatchCount: PatientCardList.matchCountFor(_searchQuery),
            listIsEmpty: false,
            onSearchChanged: (value) {
              setState(() => _searchQuery = value);
            },
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 16.h),
                sliver: PatientCardList(searchQuery: _searchQuery),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FormBackAppBar(title: 'All Patients'),
      body: AppTabletSafeArea(child: body),
    );
  }
}
