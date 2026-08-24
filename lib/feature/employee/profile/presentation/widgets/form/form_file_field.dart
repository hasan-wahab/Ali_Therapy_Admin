import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/services/image_picker_service.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/core/widgets/app_field_label.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// FORM FILE FIELD
// ------------------------------------------------------------
// Choose File for a document image (gallery).
// ============================================================

class FormFileField extends StatefulWidget {
  const FormFileField({super.key});

  @override
  State<FormFileField> createState() => _FormFileFieldState();
}

class _FormFileFieldState extends State<FormFileField> {
  String _fileName = '';
  List<int> _bytes = const [];

  Future<void> _pickFile() async {
    try {
      final file = await sl<ImagePickerService>().pickFromGallery();
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) return;
      if (!mounted) return;
      setState(() {
        _fileName = file.name;
        _bytes = bytes;
      });
    } catch (_) {
      if (!mounted) return;
      AppSnackbar.error(
        context,
        'Could not pick image. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasLocal = _bytes.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppFieldLabel(label: 'File'),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              if (hasLocal) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.memory(
                    Uint8List.fromList(_bytes),
                    width: 36.w,
                    height: 36.w,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              InkWell(
                onTap: _pickFile,
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.softGray,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Choose File',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  _fileName.isNotEmpty ? _fileName : 'No file chosen',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Image',
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}
