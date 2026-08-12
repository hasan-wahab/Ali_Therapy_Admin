import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/utils/validators.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/auth_primary_button.dart';

// ============================================================
// CHANGE PASSWORD FORM CARD
// ------------------------------------------------------------
// Current + New + Confirm (confirm only for UI match).
// API body: current_password + new_password
// Token: Authorization Bearer (auto via Dio)
// ============================================================

class ChangePasswordFormCard extends StatefulWidget {
  const ChangePasswordFormCard({super.key});

  @override
  State<ChangePasswordFormCard> createState() => _ChangePasswordFormCardState();
}

class _ChangePasswordFormCardState extends State<ChangePasswordFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    context.read<ChangePasswordBloc>().add(
          ChangePasswordSubmitted(
            currentPassword: _currentController.text,
            newPassword: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 18.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _currentController,
              label: 'Current Password',
              hintText: 'Enter current password',
              obscureText: _obscureCurrent,
              textInputAction: TextInputAction.next,
              validator: Validators.password,
              prefixIcon: Icon(
                Icons.lock_outline,
                size: AppSizes.iconMd,
                color: AppColors.textMuted,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureCurrent
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: AppSizes.iconMd,
                  color: AppColors.textMuted,
                ),
                onPressed: () {
                  setState(() => _obscureCurrent = !_obscureCurrent);
                },
              ),
            ),
            SizedBox(height: 14.h),
            AppTextField(
              controller: _passwordController,
              label: 'New Password',
              hintText: 'Enter new password',
              obscureText: _obscurePassword,
              textInputAction: TextInputAction.next,
              validator: Validators.password,
              prefixIcon: Icon(
                Icons.lock_outline,
                size: AppSizes.iconMd,
                color: AppColors.textMuted,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: AppSizes.iconMd,
                  color: AppColors.textMuted,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            SizedBox(height: 14.h),
            AppTextField(
              controller: _confirmController,
              label: 'Confirm Password',
              hintText: 'Re-enter new password',
              obscureText: _obscureConfirm,
              textInputAction: TextInputAction.done,
              validator: (value) => Validators.confirmPassword(
                value,
                _passwordController.text,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                size: AppSizes.iconMd,
                color: AppColors.textMuted,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: AppSizes.iconMd,
                  color: AppColors.textMuted,
                ),
                onPressed: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
            ),
            SizedBox(height: 22.h),
            AuthPrimaryButton(
              label: 'Update Password',
              onPressed: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
