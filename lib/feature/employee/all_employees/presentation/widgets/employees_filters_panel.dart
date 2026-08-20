import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/widgets/app_dropdown_field.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_filter_option_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_filters_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employees_list_query.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/bloc/all_employees_bloc/all_employees_bloc.dart';
import 'package:ali_therapy_admin/feature/reports/presentation/widgets/other/report_filters_header.dart';

// ============================================================
// EMPLOYEES FILTERS PANEL
// ------------------------------------------------------------
// Options from GET employees-filters-data.
// Dropdowns only update local draft values.
// API runs only when user presses "Apply Filter".
// ============================================================

class EmployeesFiltersPanel extends StatefulWidget {
  const EmployeesFiltersPanel({
    super.key,
    required this.filters,
    required this.query,
    this.onApplied,
  });

  final EmployeesFiltersEntity filters;
  final EmployeesListQuery query;
  final VoidCallback? onApplied;

  @override
  State<EmployeesFiltersPanel> createState() => _EmployeesFiltersPanelState();
}

class _EmployeesFiltersPanelState extends State<EmployeesFiltersPanel> {
  static const _allRoles = 'All Roles';
  static const _allDesignations = 'All Designations';
  static const _allClinics = 'All Clinics';
  static const _allDepartments = 'All Departments';
  static const _allShifts = 'All Shifts';
  static const _allStatuses = 'All Statuses';

  late String _role;
  late String _designation;
  late String _clinic;
  late String _department;
  late String _shift;
  late String _status;
  late String _perPage;

  int _resetToken = 0;

  List<String> get _roleItems => _withAll(widget.filters.roles, _allRoles);
  List<String> get _designationItems =>
      _withAll(widget.filters.designations, _allDesignations);
  List<String> get _clinicItems =>
      _withAll(widget.filters.clinics, _allClinics);
  List<String> get _departmentItems =>
      _withAll(widget.filters.departments, _allDepartments);
  List<String> get _shiftItems => _withAll(widget.filters.shifts, _allShifts);
  List<String> get _statusItems =>
      _withAll(widget.filters.statuses, _allStatuses);

  List<String> get _perPageItems => EmployeesListPerPage.dropdownLabels;

  @override
  void initState() {
    super.initState();
    _syncFromQuery(widget.query);
  }

  @override
  void didUpdateWidget(covariant EmployeesFiltersPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filters != widget.filters ||
        oldWidget.query != widget.query) {
      setState(() {
        _syncFromQuery(widget.query);
        _resetToken++;
      });
    }
  }

  void _syncFromQuery(EmployeesListQuery query) {
    _role = _nameForId(widget.filters.roles, query.roleId, _allRoles);
    _designation = _nameForId(
      widget.filters.designations,
      query.designationId,
      _allDesignations,
    );
    _clinic = _nameForId(widget.filters.clinics, query.clinicId, _allClinics);
    _department = _nameForId(
      widget.filters.departments,
      query.departmentId,
      _allDepartments,
    );
    _shift = _nameForId(widget.filters.shifts, query.shiftId, _allShifts);
    _status = _statusNameForParam(query.status);
    _perPage = EmployeesListPerPage.labelFor(query.perPage);
  }

  String _nameForId(
    List<EmployeeFilterOptionEntity> options,
    int? id,
    String allLabel,
  ) {
    if (id == null) return allLabel;
    for (final option in options) {
      if (int.tryParse(option.id) == id) return option.name;
    }
    return allLabel;
  }

  String _statusNameForParam(String status) {
    if (status == 'all') return _allStatuses;
    for (final option in widget.filters.statuses) {
      final value = option.value?.toString() ?? option.id;
      if (value == status) return option.name;
    }
    if (status == '1') return 'Active';
    if (status == '0') return 'Inactive';
    return _allStatuses;
  }

  List<String> _withAll(
    List<EmployeeFilterOptionEntity> options,
    String allLabel,
  ) {
    final names = options
        .map((e) => e.name)
        .where((name) => name.isNotEmpty && name != '_')
        .toList();
    return [allLabel, ...names];
  }

  int? _idForName(
    List<EmployeeFilterOptionEntity> options,
    String name,
    String allLabel,
  ) {
    if (name == allLabel) return null;
    for (final option in options) {
      if (option.name == name) {
        return int.tryParse(option.id);
      }
    }
    return null;
  }

  /// Status API: "1" / "0" / "all"
  String _statusParam(String name) {
    if (name == _allStatuses) return 'all';
    for (final option in widget.filters.statuses) {
      if (option.name == name) {
        if (option.value != null) return option.value.toString();
        if (option.id == '1' || option.id == '0') return option.id;
      }
    }
    if (name == 'Active') return '1';
    if (name == 'Inactive') return '0';
    return 'all';
  }

  EmployeesListQuery _draftQuery() {
    final roleId = _idForName(widget.filters.roles, _role, _allRoles);
    final designationId = _idForName(
      widget.filters.designations,
      _designation,
      _allDesignations,
    );
    final clinicId = _idForName(widget.filters.clinics, _clinic, _allClinics);
    final departmentId = _idForName(
      widget.filters.departments,
      _department,
      _allDepartments,
    );
    final shiftId = _idForName(widget.filters.shifts, _shift, _allShifts);

    return EmployeesListQuery(
      search: widget.query.search,
      status: _statusParam(_status),
      clinicId: clinicId,
      departmentId: departmentId,
      designationId: designationId,
      shiftId: shiftId,
      roleId: roleId,
      perPage: EmployeesListPerPage.valueForLabel(_perPage),
      page: 1,
    );
  }

  EmployeesListQuery get _normalizedAppliedQuery => EmployeesListQuery(
        search: widget.query.search,
        status: widget.query.status,
        clinicId: widget.query.clinicId,
        departmentId: widget.query.departmentId,
        designationId: widget.query.designationId,
        shiftId: widget.query.shiftId,
        roleId: widget.query.roleId,
        perPage: widget.query.perPage,
        page: 1,
      );

  bool get _hasPendingChanges => _draftQuery() != _normalizedAppliedQuery;

  void _applyFilters() {
    final draft = _draftQuery();
    final roleId = draft.roleId;
    final designationId = draft.designationId;
    final clinicId = draft.clinicId;
    final departmentId = draft.departmentId;
    final shiftId = draft.shiftId;

    context.read<AllEmployeesBloc>().add(
      AllEmployeesFiltersApplied(
        status: draft.status,
        roleId: roleId,
        designationId: designationId,
        clinicId: clinicId,
        departmentId: departmentId,
        shiftId: shiftId,
        perPage: draft.perPage,
        clearRoleId: roleId == null,
        clearDesignationId: designationId == null,
        clearClinicId: clinicId == null,
        clearDepartmentId: departmentId == null,
        clearShiftId: shiftId == null,
      ),
    );
    widget.onApplied?.call();
  }

  void _onReset() {
    setState(() {
      _syncFromQuery(widget.query.resetFilters());
      _resetToken++;
    });
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
          ReportFiltersHeader(
            onReset: _onReset,
            onApply: _applyFilters,
            applyEnabled: _hasPendingChanges,
          ),
          SizedBox(height: 6.h),
          if (AppDevice.isTablet(context))
            ..._tabletFilterRows()
          else
            ..._mobileFilterRows(),
        ],
      ),
    );
  }

  List<Widget> _mobileFilterRows() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _roleField()),
          SizedBox(width: 6.w),
          Expanded(child: _designationField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _clinicField()),
          SizedBox(width: 6.w),
          Expanded(child: _departmentField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _shiftField()),
          SizedBox(width: 6.w),
          Expanded(child: _statusField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _perPageField()),
          const Spacer(),
        ],
      ),
    ];
  }

  List<Widget> _tabletFilterRows() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _roleField()),
          SizedBox(width: 6.w),
          Expanded(child: _designationField()),
          SizedBox(width: 6.w),
          Expanded(child: _clinicField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _departmentField()),
          SizedBox(width: 6.w),
          Expanded(child: _shiftField()),
          SizedBox(width: 6.w),
          Expanded(child: _statusField()),
        ],
      ),
      SizedBox(height: 4.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _perPageField()),
          const Spacer(flex: 2),
        ],
      ),
    ];
  }

  Widget _roleField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('role_$_resetToken'),
      label: 'Role',
      hintText: _allRoles,
      enableSearch: true,
      items: _roleItems,
      value: _role,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _role = value);
      },
    );
  }

  Widget _designationField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('designation_$_resetToken'),
      label: 'Designation',
      hintText: _allDesignations,
      enableSearch: true,
      items: _designationItems,
      value: _designation,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _designation = value);
      },
    );
  }

  Widget _clinicField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('clinic_$_resetToken'),
      label: 'Clinic',
      hintText: _allClinics,
      enableSearch: true,
      items: _clinicItems,
      value: _clinic,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _clinic = value);
      },
    );
  }

  Widget _departmentField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('department_$_resetToken'),
      label: 'Department',
      hintText: _allDepartments,
      enableSearch: true,
      items: _departmentItems,
      value: _department,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _department = value);
      },
    );
  }

  Widget _shiftField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('shift_$_resetToken'),
      label: 'Shift',
      hintText: _allShifts,
      enableSearch: true,
      items: _shiftItems,
      value: _shift,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _shift = value);
      },
    );
  }

  Widget _statusField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('status_$_resetToken'),
      label: 'Status',
      hintText: _allStatuses,
      enableSearch: true,
      items: _statusItems,
      value: _status,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _status = value);
      },
    );
  }

  Widget _perPageField() {
    return AppDropdownField(
      compact: true,
      key: ValueKey('per_page_$_resetToken'),
      label: 'Per Page',
      hintText: '50',
      items: _perPageItems,
      value: _perPage,
      onChanged: (value) {
        if (value == null) return;
        setState(() => _perPage = value);
      },
    );
  }

}
