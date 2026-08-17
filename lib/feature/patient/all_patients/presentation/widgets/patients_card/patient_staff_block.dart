import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_fields_grid.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_section_title.dart';
import 'package:ali_therapy_admin/feature/patient/all_patients/presentation/widgets/patients_card/patient_staff_cell.dart';

// ============================================================
// PATIENT STAFF BLOCK
// ------------------------------------------------------------
// Staff details in a compact labeled grid (2 cols phone, 3 tablet).
// ============================================================

class PatientStaffBlock extends StatelessWidget {
  const PatientStaffBlock({
    super.key,
    required this.createdBy,
    this.receptionist = '—',
    this.assistantManager = '—',
    this.historyTaker = '—',
    this.consultant = '—',
    this.therapist = '—',
  });

  final String createdBy;
  final String receptionist;
  final String assistantManager;
  final String historyTaker;
  final String consultant;
  final String therapist;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PatientSectionTitle(title: 'Staff Details'),
          SizedBox(height: 6.h),
          AppTabletFieldsGrid(
            phoneColumns: 2,
            tabletColumns: 3,
            children: [
              PatientStaffCell(
                label: 'Created By',
                value: createdBy,
              ),
              PatientStaffCell(
                label: 'Receptionist',
                value: receptionist,
              ),
              PatientStaffCell(
                label: 'AM',
                value: assistantManager,
              ),
              PatientStaffCell(
                label: 'History Taker',
                value: historyTaker,
              ),
              PatientStaffCell(
                label: 'Consultant',
                value: consultant,
              ),
              PatientStaffCell(
                label: 'Therapist',
                value: therapist,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
