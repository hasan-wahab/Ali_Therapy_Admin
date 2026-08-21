import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patient_card_list.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_filters_panel.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_search_filter_section.dart';

// ============================================================
// ALL PATIENTS PAGE
// ------------------------------------------------------------
// Same search + filter flow as Patient Dues:
// debounce search, Enter submits, Apply on filters, matches first.
// ============================================================

class AllPatientsPage extends StatefulWidget {
  const AllPatientsPage({super.key});

  @override
  State<AllPatientsPage> createState() => _AllPatientsPageState();
}

class _AllPatientsPageState extends State<AllPatientsPage> {
  static const _debounceDuration = Duration(milliseconds: 450);

  String _searchQuery = '';
  String _clinic = PatientsFiltersPanel.allClinics;
  String _receptionist = PatientsFiltersPanel.allReceptionists;
  String? _fromDate;
  String? _toDate;
  Timer? _searchDebounce;

  bool get _hasActiveFilters =>
      _clinic != PatientsFiltersPanel.allClinics ||
      _receptionist != PatientsFiltersPanel.allReceptionists ||
      _fromDate != null ||
      _toDate != null;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_debounceDuration, () {
      if (!mounted) return;
      setState(() => _searchQuery = value);
    });
  }

  void _onSearchSubmitted(String value) {
    _searchDebounce?.cancel();
    setState(() => _searchQuery = value);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppDevice.isTablet(context);
    final hPad = isTablet
        ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
        : 12.w;

    final matchCount = PatientCardList.matchCountFor(
      _searchQuery,
      receptionist: _receptionist,
    );
    final listIsEmpty = !PatientCardList.hasRows(receptionist: _receptionist);

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(hPad, 8.h, hPad, 10.h),
          child: PatientsSearchFilterSection(
            clinic: _clinic,
            receptionist: _receptionist,
            fromDate: _fromDate,
            toDate: _toDate,
            searchQuery: _searchQuery,
            searchMatchCount: matchCount,
            listIsEmpty: listIsEmpty,
            hasActiveFilters: _hasActiveFilters,
            onSearchChanged: _onSearchChanged,
            onSearchSubmitted: _onSearchSubmitted,
            onFiltersApply: ({
              required clinic,
              required receptionist,
              fromDate,
              toDate,
            }) {
              setState(() {
                _clinic = clinic;
                _receptionist = receptionist;
                _fromDate = fromDate;
                _toDate = toDate;
              });
            },
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(hPad, 0, hPad, 16.h),
                sliver: PatientCardList(
                  searchQuery: _searchQuery,
                  receptionist: _receptionist,
                ),
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
