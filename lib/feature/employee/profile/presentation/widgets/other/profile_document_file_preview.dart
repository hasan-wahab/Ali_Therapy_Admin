import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/network/dio_client.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';
import 'package:ali_therapy_admin/core/utils/app_debug_logger.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// PROFILE DOCUMENT FILE PREVIEW
// ------------------------------------------------------------
// Loads the document image with the same auth as other APIs.
// Non-image files (PDF, Word, …) show a file name chip.
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

  static const _nonImageExtensions = {
    '.pdf',
    '.doc',
    '.docx',
    '.xls',
    '.xlsx',
    '.csv',
    '.ppt',
    '.pptx',
    '.zip',
    '.rar',
    '.txt',
  };

  bool get _hasUrl {
    final url = widget.fileUrl.trim();
    return url.isNotEmpty && url != '_';
  }

  String get _extension {
    final name = widget.fileName.trim().toLowerCase().split('?').first;
    final dot = name.lastIndexOf('.');
    if (dot < 0) return '';
    return name.substring(dot);
  }

  bool get _isKnownNonImage => _nonImageExtensions.contains(_extension);

  bool get _shouldTryImage {
    if (!_hasUrl || _isKnownNonImage) return false;
    return true;
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
    if (!_shouldTryImage) return null;

    final bytes = await sl<DioClient>().getFileBytes(widget.fileUrl.trim());
    if (bytes == null || bytes.isEmpty) {
      AppDebugLogger.action(
        where: 'ProfileDocumentFilePreview',
        action: 'LOAD FAIL',
        detail: widget.fileUrl,
      );
      return null;
    }
    if (!_looksLikeImage(bytes)) return null;
    return bytes;
  }

  /// JPEG / PNG / GIF / WEBP / BMP magic bytes.
  bool _looksLikeImage(Uint8List bytes) {
    if (bytes.length < 12) return false;
    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) return true;
    if (bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return true;
    }
    if (bytes[0] == 0x47 && bytes[1] == 0x49 && bytes[2] == 0x46) return true;
    if (bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46 &&
        bytes[8] == 0x57 &&
        bytes[9] == 0x45 &&
        bytes[10] == 0x42 &&
        bytes[11] == 0x50) {
      return true;
    }
    if (bytes[0] == 0x42 && bytes[1] == 0x4D) return true;
    return false;
  }

  Widget _fileChip() {
    final label = widget.fileName.trim().isEmpty ? 'File' : widget.fileName;
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
              label,
              style: AppTextStyles.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageUnavailable() {
    return _imageBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.broken_image_outlined,
            color: AppColors.textMuted,
            size: AppSizes.iconLg,
          ),
          SizedBox(height: 8.h),
          Text(
            'Server blocked this file',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _imageBox({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        width: double.infinity,
        height: 220.h,
        color: AppColors.softGray,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasUrl) return _fileChip();
    if (!_shouldTryImage) return _fileChip();

    return FutureBuilder<Uint8List?>(
      future: _bytesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _imageBox(
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
        if (bytes == null || bytes.isEmpty) {
          return _isKnownNonImage ? _fileChip() : _imageUnavailable();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 280.h),
            child: Image.memory(
              bytes,
              width: double.infinity,
              fit: BoxFit.contain,
              gaplessPlayback: true,
              errorBuilder: (_, __, ___) => _imageUnavailable(),
            ),
          ),
        );
      },
    );
  }
}
