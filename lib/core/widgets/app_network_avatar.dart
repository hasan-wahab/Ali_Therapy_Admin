import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/services/auth_local_storage.dart';
import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_sizes.dart';
import 'package:ali_therapy_admin/injection.dart';

// ============================================================
// APP NETWORK AVATAR (shared)
// ------------------------------------------------------------
// Loads profile images from the API server.
// Storage URLs need: Authorization: Bearer <token>
// (same as doctor_app). On fail → person icon.
// ============================================================

class AppNetworkAvatar extends StatefulWidget {
  const AppNetworkAvatar({
    super.key,
    this.imageUrl,
    this.radius,
    this.iconSize,
  });

  final String? imageUrl;

  /// Circle radius. Default: 22.r
  final double? radius;

  /// Placeholder icon size. Default: AppSizes.iconMd
  final double? iconSize;

  @override
  State<AppNetworkAvatar> createState() => _AppNetworkAvatarState();
}

class _AppNetworkAvatarState extends State<AppNetworkAvatar> {
  late Future<Uint8List?> _imageBytesFuture;

  bool get _hasUrl {
    final url = widget.imageUrl?.trim();
    return url != null && url.isNotEmpty && url != '_';
  }

  Map<String, String>? _authHeaders() {
    final token = sl<AuthLocalStorage>().getTokenSync();
    if (token == null) return null;
    return {'Authorization': 'Bearer $token'};
  }

  @override
  void initState() {
    super.initState();
    _imageBytesFuture = _loadImageBytes();
  }

  @override
  void didUpdateWidget(covariant AppNetworkAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _imageBytesFuture = _loadImageBytes();
    }
  }

  Widget _placeholder({required double r, required double icon}) {
    return CircleAvatar(
      radius: r,
      backgroundColor: AppColors.primaryLight,
      child: Icon(
        Icons.person_rounded,
        color: AppColors.primary,
        size: icon,
      ),
    );
  }

  Future<Uint8List?> _loadImageBytes() async {
    if (!_hasUrl) return null;

    try {
      final response = await Dio().get<List<int>>(
        widget.imageUrl!.trim(),
        options: Options(
          headers: _authHeaders(),
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
          validateStatus: (status) => status != null && status >= 200 && status < 300,
        ),
      );

      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) return null;
      return Uint8List.fromList(bytes);
    } catch (_) {
      // Broken URL, forbidden file, or missing auth should quietly fall back.
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.radius ?? 22.r;
    final icon = widget.iconSize ?? AppSizes.iconMd;

    if (!_hasUrl) {
      return _placeholder(r: r, icon: icon);
    }

    return FutureBuilder<Uint8List?>(
      future: _imageBytesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return ClipOval(
            child: SizedBox(
              width: r * 2,
              height: r * 2,
              child: ColoredBox(
                color: AppColors.primaryLight,
                child: Center(
                  child: SizedBox(
                    width: icon,
                    height: icon,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        final bytes = snapshot.data;
        if (bytes == null || bytes.isEmpty) {
          return _placeholder(r: r, icon: icon);
        }

        return ClipOval(
          child: SizedBox(
            width: r * 2,
            height: r * 2,
            child: Image.memory(
              bytes,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
        );
      },
    );
  }
}
