import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/routes/navigation_helper.dart';
import 'package:ali_therapy_admin/core/services/image_picker_service.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/domain/patient_registration_domain/entities/patient_form_data_entity.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/bloc/patient_registration_bloc/patient_registration_bloc.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_back_app_bar.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/presentation/widgets/form/patient_registration_form_controllers.dart';
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
// Load: GET patients/form-data
// Edit load: GET patients/{id}/edit (fallback: full-view)
// Submit (register): POST patients/create
// Submit (update): POST patients/{id}/update
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

  final PatientRegistrationFormControllers _form =
      PatientRegistrationFormControllers();
  final ScrollController _scrollController = ScrollController();
  int _currentStep = 0;
  bool _filled = false;
  bool _allowRoutePop = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _form.disposeAll();
    super.dispose();
  }

  void _fillIfNeeded(PatientRegistrationLoaded state) {
    if (!widget.isEdit || _filled) return;
    final patient = state.patient;
    if (patient == null) return;
    _form.fillFrom(patient, state.formData);
    _filled = true;
    if (mounted) setState(() {});
  }

  String? _patientIdFromRoute(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    if (extra is String && extra.trim().isNotEmpty && extra != '_') {
      return extra.trim();
    }
    return null;
  }

  void _goNext(PatientFormDataEntity formData) {
    final error = _form.validateStep(_currentStep, formData);
    if (error != null) {
      AppSnackbar.error(context, error, title: 'Check form');
      _scrollToTop();
      return;
    }
    if (_currentStep >= _stepLabels.length - 1) return;
    setState(() => _currentStep += 1);
    _scrollToTop();
  }

  void _goBack() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
      _scrollToTop();
      return;
    }
    _popPage();
  }

  void _popPage() {
    if (!mounted) return;
    setState(() => _allowRoutePop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      AppNavigation.back(context);
    });
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
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
      _form.setImage(bytes: bytes, name: file.name);
    } catch (_) {
      if (!mounted) return;
      AppSnackbar.error(
        context,
        'Could not pick image. Please try again.',
      );
    }
  }

  void _submitPatient(
    BuildContext context,
    PatientFormDataEntity formData,
  ) {
    final error = _form.validateForCreate(formData);
    if (error != null) {
      AppSnackbar.error(context, error, title: 'Check form');
      _scrollToTop();
      return;
    }

    // Use BlocConsumer context — the page context sits above BlocProvider.
    final form = _form.toForm();
    if (widget.isEdit) {
      final patientId = form.id.isNotEmpty
          ? form.id
          : (_patientIdFromRoute(context) ?? '');
      context.read<PatientRegistrationBloc>().add(
        PatientRegistrationUpdated(patientId: patientId, form: form),
      );
      return;
    }

    context.read<PatientRegistrationBloc>().add(
      PatientRegistrationSubmitted(form: form),
    );
  }

  Widget _buildStepContent(PatientFormDataEntity formData) {
    switch (_currentStep) {
      case 0:
        return BasicInfoSection(form: _form, formData: formData);
      case 1:
        return AdditionalDetailsSection(form: _form, formData: formData);
      case 2:
        return ListenableBuilder(
          listenable: _form,
          builder: (context, _) {
            return PatientImageSection(
              photoBytes: _form.imageBytes,
              imageUrl: _form.imageUrl,
              fileName: _form.imageName,
              onPickCamera: () => _pickPatientPhoto(fromCamera: true),
              onPickGallery: () => _pickPatientPhoto(fromCamera: false),
            );
          },
        );
      default:
        return BasicInfoSection(form: _form, formData: formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final patientId = widget.isEdit ? _patientIdFromRoute(context) : null;
    final isFirst = _currentStep == 0;
    final isLast = _currentStep == _stepLabels.length - 1;
    final title = widget.isEdit ? 'Edit Patient' : 'Patient Registration';
    final submitLabel = widget.isEdit ? 'Update Patient' : 'Register Patient';

    return BlocProvider(
      create: (_) {
        final bloc = sl<PatientRegistrationBloc>();
        bloc.add(
          PatientRegistrationStarted(
            patientId: widget.isEdit ? (patientId ?? '') : null,
          ),
        );
        return bloc;
      },
      child: BlocConsumer<PatientRegistrationBloc, PatientRegistrationState>(
        listenWhen: (previous, current) {
          if (current is PatientRegistrationError) return true;
          if (current is PatientRegistrationLoaded) {
            if (previous is! PatientRegistrationLoaded) return true;
            return current.successMessage != null;
          }
          return false;
        },
        listener: (context, state) {
          if (state is PatientRegistrationError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
          if (state is PatientRegistrationLoaded) {
            _fillIfNeeded(state);
            final message = state.successMessage;
            if (message != null && message.isNotEmpty) {
              AppSnackbar.success(context, message);
              AppNavigation.back(context);
            }
          }
        },
        builder: (context, state) {
          if (state is PatientRegistrationLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              _fillIfNeeded(state);
            });
          }
          final isLoading = state is PatientRegistrationLoading ||
              state is PatientRegistrationInitial;
          final isSaving =
              state is PatientRegistrationLoaded && state.isSaving;
          final formData = state is PatientRegistrationLoaded
              ? state.formData
              : null;

          return PopScope(
            canPop: !isSaving && (_currentStep == 0 || _allowRoutePop),
            onPopInvokedWithResult: (didPop, result) {
              if (didPop || isSaving) return;
              _goBack();
            },
            child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: PatientBackAppBar(
              title: title,
              isLoading: isLoading || isSaving,
              onBack: isSaving ? () {} : _goBack,
            ),
            body: AppTabletSafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 12.h),
                          child: formData == null
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    PatientStepIndicator(
                                      currentStep: _currentStep,
                                      labels: _stepLabels,
                                    ),
                                    SizedBox(height: 16.h),
                                    _buildStepContent(formData),
                                  ],
                                ),
                        ),
                      ),
                      if (formData != null)
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                          child: PatientStepFooter(
                            isFirstStep: isFirst,
                            isLastStep: isLast,
                            onBack: isSaving ? () {} : _goBack,
                            onNext: isSaving
                                ? () {}
                                : () => _goNext(formData),
                            onRegister: isSaving
                                ? () {}
                                : () => _submitPatient(context, formData),
                            submitLabel: submitLabel,
                          ),
                        ),
                    ],
                  ),
                  if (isLoading)
                    AppLoadingOverlay(
                      message: widget.isEdit
                          ? 'Loading patient...'
                          : 'Loading form...',
                      subtitle: 'Please wait',
                    )
                  else if (isSaving)
                    AppLoadingOverlay(
                      message: widget.isEdit
                          ? 'Updating patient...'
                          : 'Registering patient...',
                      subtitle: 'Please wait',
                    ),
                ],
              ),
            ),
          ),
          );
        },
      ),
    );
  }
}
