import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/utils/validators.dart';
import 'package:ali_therapy_admin/core/widgets/app_text_field.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'package:ali_therapy_admin/feature/auth/presentation/widgets/auth_primary_button.dart';

// ============================================================
// FORGOT PASSWORD FORM CARD
// ------------------------------------------------------------
// UI only → ForgetPasswordSubmitted event.
// ============================================================

class ForgotPasswordFormCard extends StatefulWidget {
  const ForgotPasswordFormCard({super.key});

  @override
  State<ForgotPasswordFormCard> createState() => _ForgotPasswordFormCardState();
}

class _ForgotPasswordFormCardState extends State<ForgotPasswordFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    context.read<ForgetPasswordBloc>().add(
          ForgetPasswordSubmitted(email: _emailController.text.trim()),
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
              controller: _emailController,
              label: 'Email',
              hintText: 'admin@example.com',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: Validators.email,
              prefixIcon: Icon(
                Icons.email_outlined,
                size: AppSizes.iconMd,
                color: AppColors.textMuted,
              ),
            ),
            SizedBox(height: 22.h),
            AuthPrimaryButton(
              label: 'Send Reset Link',
              onPressed: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
