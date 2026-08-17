import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/domain/all_employees_domain/entities/employee_entity.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employee_card_mapper.dart';
import 'package:ali_therapy_admin/feature/employee/all_employees/presentation/widgets/employees_card/employee_card.dart';

// ============================================================
// EMPLOYEE CARD LIST
// ------------------------------------------------------------
// Builds cards from API employees (card fields from API).
// ============================================================

class EmployeeCardList extends StatelessWidget {
  const EmployeeCardList({super.key, required this.employees});

  final List<EmployeeEntity> employees;

  @override
  Widget build(BuildContext context) {
    if (employees.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            'No employees found',
            style: AppTextStyles.body.copyWith(color: AppColors.textMuted),
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: employees.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final employee = employees[index];

        return EmployeeCard(
          initiallyExpanded: index == 0,
          id: employee.id,
          name: EmployeeCardMapper.name(employee),
          email: EmployeeCardMapper.email(employee),
          phone: EmployeeCardMapper.phone(employee),
          cnic: EmployeeCardMapper.cnic(employee),
          employeeId: EmployeeCardMapper.employeeId(employee),
          joinedDate: EmployeeCardMapper.joinedDate(employee),
          tenure: EmployeeCardMapper.tenure(employee),
          roles: EmployeeCardMapper.roles(employee),
          shift: EmployeeCardMapper.shift(employee),
          createdBy: EmployeeCardMapper.createdBy(employee),
          imageUrl: EmployeeCardMapper.imageUrl(employee),
          isActive: EmployeeCardMapper.isActive(employee),
        );
      },
    );
  }
}
