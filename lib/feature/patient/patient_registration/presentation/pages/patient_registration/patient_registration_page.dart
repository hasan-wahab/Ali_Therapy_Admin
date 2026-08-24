import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/services/image_picker_service.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_step_footer.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_step_indicator.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/sections/additional_details/additional_details_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/sections/basic_info/basic_info_section.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/sections/patient_image/patient_image_section.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PATIENT REGISTRATION PAGE
// ------------------------------------------------------------
// 3-step wizard: Basic → Additional → Photo.
// Also reused for Edit Patient (same forms).
// ============================================================

class PatientRegistrationPage extends StatefulWidget {
  const PatientRegistrationPage({
    super.key,
    this.isEdit = false,
  });

  /// When true, shows Edit titles / Update action (same form steps).
  final bool isEdit;

  @override
  State<PatientRegistrationPage> createState() =>
      _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  static const _stepLabels = ['Basic Info', 'Details', 'Photo'];

  int _currentStep = 0;
  List<int> _photoBytes = const [];
  String _photoName = '';

  void _goNext() {
    if (_currentStep >= _stepLabels.length - 1) return;
    setState(() => _currentStep += 1);
  }

  void _goBack() {
    if (_currentStep <= 0) return;
    setState(() => _currentStep -= 1);
  }

  Future<void> _pickPatientPhoto({required bool fromCamera}) async {
    try {
      final file = fromCamera
          ? await sl<ImagePickerService>().pickFromCamera()
          : await sl<ImagePickerService>().pickFromGallery();
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) return;
      if (!mounted) return;
      setState(() {
        _photoBytes = bytes;
        _photoName = file.name;
      });
    } catch (_) {
      if (!mounted) return;
      AppSnackbar.error(
        context,
        'Could not pick image. Please try again.',
      );
    }
  }

  void _submitPatient() {
    // UI only — API wiring comes later.
    if (widget.isEdit) {
      AppSnackbar.success(context, 'Patient updated successfully (UI only).');
    } else {
      AppSnackbar.success(context, 'Patient registered successfully (UI only).');
    }
    AppNavigation.back(context);
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return const BasicInfoSection();
      case 1:
        return const AdditionalDetailsSection();
      case 2:
        return PatientImageSection(
          photoBytes: _photoBytes,
          fileName: _photoName,
          onPickCamera: () => _pickPatientPhoto(fromCamera: true),
          onPickGallery: () => _pickPatientPhoto(fromCamera: false),
        );
      default:
        return const BasicInfoSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFirst = _currentStep == 0;
    final isLast = _currentStep == _stepLabels.length - 1;
    final title = widget.isEdit ? 'Edit Patient' : 'Patient Registration';
    final submitLabel = widget.isEdit ? 'Update Patient' : 'Register Patient';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PatientBackAppBar(title: title),
      body: AppTabletSafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PatientStepIndicator(
                      currentStep: _currentStep,
                      labels: _stepLabels,
                    ),
                    SizedBox(height: 16.h),
                    _buildStepContent(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
              child: PatientStepFooter(
                isFirstStep: isFirst,
                isLastStep: isLast,
                onBack: _goBack,
                onNext: _goNext,
                onRegister: _submitPatient,
                submitLabel: submitLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
