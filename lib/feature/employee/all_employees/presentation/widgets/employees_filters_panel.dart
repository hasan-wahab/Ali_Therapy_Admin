import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// EMPLOYEES FILTERS PANEL
// ------------------------------------------------------------
// Same filter style as reports / web employees filters.
// Searchable dropdowns: role, designation, clinic, department,
// shift, status + Reset. UI only until API is wired.
// ============================================================

class EmployeesFiltersPanel extends StatefulWidget {
  const EmployeesFiltersPanel({super.key});

  @override
  State<EmployeesFiltersPanel> createState() => _EmployeesFiltersPanelState();
}

class _EmployeesFiltersPanelState extends State<EmployeesFiltersPanel> {
  static const _roles = [
    'All Roles',
    'Accountant',
    'Admin',
    'Assistant Manager',
    'Cash Collector',
    'Consultant',
  ];

  static const _designations = [
    'All Designations',
    'CEO',
    'COO',
    'Manager',
    'Assistant Manager',
    'Physiotherapist',
  ];

  static const _clinics = [
    'All Clinics',
    'Clinic 1',
    'Clinic 2',
    'Clinic 3 (Neuro and Stroke)',
    'Corporate',
  ];

  static const _departments = [
    'All Departments',
    'Physiotherapy',
    'Sales',
    'Marketing',
    'Management',
    'Reception',
  ];

  static const _shifts = [
    'All Shifts',
    'Morning Shift (8AM - 4PM)',
    'Morning Shift (9AM - 5PM)',
    'Mid Shift (11AM - 7PM)',
    'Mid Shift (12PM - 8PM)',
    'Evening Shift (4PM - 12AM)',
  ];

  static const _statuses = [
    'All Statuses',
    'Active',
    'Inactive',
  ];

  late String _role;
  late String _designation;
  late String _clinic;
  late String _department;
  late String _shift;
  late String _status;

  /// Bumps keys so dropdowns rebuild after Reset.
  int _resetToken = 0;

  @override
  void initState() {
    super.initState();
    _resetValues();
  }

  void _resetValues() {
    _role = _roles.first;
    _designation = _designations.first;
    _clinic = _clinics.first;
    _department = _departments.first;
    _shift = _shifts.first;
    _status = 'Active';
  }

  void _onReset() {
    setState(() {
      _resetValues();
      _resetToken++;
    });
    AppSnackbar.info(context, 'Filters reset (UI only)');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReportFiltersHeader(onReset: _onReset),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppDropdownField(
                  compact: true,
                  key: ValueKey('role_$_resetToken'),
                  label: 'Role',
                  hintText: 'All Roles',
                  enableSearch: true,
                  items: _roles,
                  value: _role,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _role = value);
                  },
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: AppDropdownField(
                  compact: true,
                  key: ValueKey('designation_$_resetToken'),
                  label: 'Designation',
                  hintText: 'All Designations',
                  enableSearch: true,
                  items: _designations,
                  value: _designation,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _designation = value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppDropdownField(
                  compact: true,
                  key: ValueKey('clinic_$_resetToken'),
                  label: 'Clinic',
                  hintText: 'All Clinics',
                  enableSearch: true,
                  items: _clinics,
                  value: _clinic,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _clinic = value);
                  },
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: AppDropdownField(
                  compact: true,
                  key: ValueKey('department_$_resetToken'),
                  label: 'Department',
                  hintText: 'All Departments',
                  enableSearch: true,
                  items: _departments,
                  value: _department,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _department = value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppDropdownField(
                  compact: true,
                  key: ValueKey('shift_$_resetToken'),
                  label: 'Shift',
                  hintText: 'All Shifts',
                  enableSearch: true,
                  items: _shifts,
                  value: _shift,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _shift = value);
                  },
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: AppDropdownField(
                  compact: true,
                  key: ValueKey('status_$_resetToken'),
                  label: 'Status',
                  hintText: 'All Statuses',
                  enableSearch: true,
                  items: _statuses,
                  value: _status,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() => _status = value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
