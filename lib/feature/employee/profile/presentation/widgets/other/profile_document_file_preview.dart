import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PROFILE DOCUMENT FILE PREVIEW
// ------------------------------------------------------------
// Image files load with Bearer token. Other files show a file chip.
// ============================================================

class ProfileDocumentFilePreview extends StatefulWidget {
  const ProfileDocumentFilePreview({
    super.key,
    required this.fileUrl,
    required this.fileName,
  });

  final String fileUrl;
  final String fileName;

  @override
  State<ProfileDocumentFilePreview> createState() =>
      _ProfileDocumentFilePreviewState();
}

class _ProfileDocumentFilePreviewState
    extends State<ProfileDocumentFilePreview> {
  late Future<Uint8List?> _bytesFuture;

  bool get _hasUrl {
    final url = widget.fileUrl.trim();
    return url.isNotEmpty && url != '_';
  }

  bool get _isImage {
    final name = widget.fileName.toLowerCase();
    return name.endsWith('.jpg') ||
        name.endsWith('.jpeg') ||
        name.endsWith('.png') ||
        name.endsWith('.gif') ||
        name.endsWith('.webp') ||
        name.endsWith('.bmp');
  }

  Map<String, String>? _authHeaders() {
    final token = sl<AuthLocalStorage>().getTokenSync();
    if (token == null) return null;
    return {'Authorization': 'Bearer $token'};
  }

  @override
  void initState() {
    super.initState();
    _bytesFuture = _loadBytes();
  }

  @override
  void didUpdateWidget(covariant ProfileDocumentFilePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fileUrl != widget.fileUrl) {
      _bytesFuture = _loadBytes();
    }
  }

  Future<Uint8List?> _loadBytes() async {
    if (!_hasUrl || !_isImage) return null;

    try {
      final response = await Dio().get<List<int>>(
        widget.fileUrl.trim(),
        options: Options(
          headers: _authHeaders(),
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
          validateStatus: (status) =>
              status != null && status >= 200 && status < 300,
        ),
      );
      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) return null;
      return Uint8List.fromList(bytes);
    } catch (_) {
      return null;
    }
  }

  Widget _fileChip() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            color: AppColors.primary,
            size: AppSizes.iconMd,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              widget.fileName.isEmpty ? '—' : widget.fileName,
              style: AppTextStyles.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasUrl) return _fileChip();
    if (!_isImage) return _fileChip();

    return FutureBuilder<Uint8List?>(
      future: _bytesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            height: 140.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.softGray,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.border),
            ),
            child: SizedBox(
              width: 22.w,
              height: 22.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          );
        }

        final bytes = snapshot.data;
        if (bytes == null || bytes.isEmpty) return _fileChip();

        return ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.memory(
            bytes,
            height: 180.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
