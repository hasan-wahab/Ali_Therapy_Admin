import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_loading_dialog.dart';
import 'package:ali_therapy_admin/core/widgets/app_tablet_safe_area.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/domain/edit_employee_domain/entities/edit_employee_options_entity.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/bloc/edit_employee_bloc/edit_employee_bloc.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_footer.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_form_controllers.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/form/edit_employee_step.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/bank_details/bank_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/details/details_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/documents/documents_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/education/education_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/experience/experience_section.dart';
import 'package:ali_therapy_admin/feature/employee/edit_employee/presentation/widgets/sections/user_details/user_details_section.dart';
import 'package:ali_therapy_admin/feature/employee/profile/presentation/widgets/form/form_back_app_bar.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// EDIT EMPLOYEE PAGE
// ------------------------------------------------------------
// Opened from All Employees → Edit with employee id in extra.
// Load: GET employees/{id} (same as View)
// Submit: POST employees/update/{id}
// ============================================================

class EditEmployeePage extends StatefulWidget {
  const EditEmployeePage({super.key});

  @override
  State<EditEmployeePage> createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final EditEmployeeFormControllers _form = EditEmployeeFormControllers();
  final ScrollController _scrollController = ScrollController();
  EditEmployeeStep _step = EditEmployeeStep.userDetails;
  bool _filled = false;
  bool _allowRoutePop = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _form.dispose();
    super.dispose();
  }

  String? _employeeIdFromRoute(BuildContext context) {
    final extra = GoRouterState.of(context).extra;
    if (extra is String && extra.trim().isNotEmpty && extra != '_') {
      return extra.trim();
    }
    return null;
  }

  void _goBack(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    final previous = _step.previous;
    if (previous == null) {
      _popPage(context);
      return;
    }
    setState(() => _step = previous);
    _scrollToAppBar();
  }

  void _popPage(BuildContext context) {
    if (!mounted) return;
    setState(() => _allowRoutePop = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      if (context.canPop()) {
        context.pop();
      }
    });
  }

  void _goNext(BuildContext context) {
    final error = _form.validateStep(_step);
    if (error != null) {
      AppSnackbar.error(context, error, title: 'Check form');
      _scrollToAppBar();
      return;
    }
    final next = _step.next;
    if (next == null) {
      _submit(context);
      return;
    }
    setState(() => _step = next);
    _scrollToAppBar();
  }

  void _scrollToAppBar() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  void _submit(BuildContext context) {
    final error = _form.validateForUpdate();
    if (error != null) {
      AppSnackbar.error(context, error, title: 'Check form');
      _scrollToAppBar();
      return;
    }

    context.read<EditEmployeeBloc>().add(
      EditEmployeeSubmitted(form: _form.toForm()),
    );
  }

  Widget _buildSection(EditEmployeeOptionsEntity options) {
    switch (_step) {
      case EditEmployeeStep.userDetails:
        return UserDetailsSection(form: _form, options: options);
      case EditEmployeeStep.details:
        return DetailsSection(form: _form, options: options);
      case EditEmployeeStep.bankDetails:
        return EditBankDetailsSection(form: _form);
      case EditEmployeeStep.documents:
        return EditDocumentsSection(form: _form);
      case EditEmployeeStep.education:
        return EditEducationSection(form: _form);
      case EditEmployeeStep.experience:
        return EditExperienceSection(form: _form);
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeeId = _employeeIdFromRoute(context);

    return BlocProvider(
      create: (_) {
        final bloc = sl<EditEmployeeBloc>();
        bloc.add(EditEmployeeStarted(employeeId: employeeId ?? ''));
        return bloc;
      },
      child: BlocConsumer<EditEmployeeBloc, EditEmployeeState>(
        listenWhen: (previous, current) {
          if (current is EditEmployeeError) return true;
          if (current is EditEmployeeLoaded) {
            if (previous is! EditEmployeeLoaded) return true;
            return current.successMessage != null;
          }
          return false;
        },
        listener: (context, state) {
          if (state is EditEmployeeError) {
            AppSnackbar.error(context, state.message, title: state.title);
          }
          if (state is EditEmployeeLoaded) {
            if (!_filled) {
              _form.fillFrom(state.page.form);
              if (_form.employeeId.isEmpty && employeeId != null) {
                _form.employeeId = employeeId;
              }
              _filled = true;
            }
            final message = state.successMessage;
            if (message != null && message.isNotEmpty) {
              AppSnackbar.success(context, message);
              _popPage(context);
            }
          }
        },
        builder: (context, state) {
          final isLoading =
              state is EditEmployeeLoading || state is EditEmployeeInitial;
          final isSaving = state is EditEmployeeLoaded && state.isSaving;
          final loaded = state is EditEmployeeLoaded ? state : null;
          final options =
              loaded?.page.options ?? const EditEmployeeOptionsEntity.empty();

          return PopScope(
            // Device back: previous section, or leave on the first section.
            canPop: !isSaving && (_step.isFirst || _allowRoutePop),
            onPopInvokedWithResult: (didPop, result) {
              if (didPop || isSaving) return;
              _goBack(context);
            },
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: FormBackAppBar(
                title: 'Edit Employee',
                isLoading: isLoading || isSaving,
                onBack: isSaving ? () {} : () => _goBack(context),
              ),
              body: AppTabletSafeArea(
                child: employeeId == null
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Text(
                            'Open an employee from All Employees → Edit.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body,
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  padding: EdgeInsets.fromLTRB(
                                    12.w,
                                    8.h,
                                    12.w,
                                    16.h,
                                  ),
                                  child: loaded == null
                                      ? const SizedBox.shrink()
                                      : _buildSection(options),
                                ),
                              ),
                              if (loaded != null)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.fromLTRB(
                                    16.w,
                                    10.h,
                                    16.w,
                                    12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    border: Border(
                                      top: BorderSide(color: AppColors.border),
                                    ),
                                  ),
                                  child: EditEmployeeFooter(
                                    isFirstStep: _step.isFirst,
                                    isLastStep: _step.isLast,
                                    onBack: isSaving
                                        ? () {}
                                        : () => _goBack(context),
                                    onNext: isSaving
                                        ? () {}
                                        : () => _goNext(context),
                                  ),
                                ),
                            ],
                          ),
                          if (isLoading)
                            const AppLoadingOverlay(
                              message: 'Loading employee...',
                              subtitle: 'Please wait',
                            )
                          else if (isSaving)
                            const AppLoadingOverlay(
                              message: 'Updating...',
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
