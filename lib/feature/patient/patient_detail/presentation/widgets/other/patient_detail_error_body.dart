import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_placeholder_body.dart';

// ============================================================
// PATIENT DETAIL ERROR BODY
// ------------------------------------------------------------
// On-screen message when Full View fails (not found / no internet).
// Shown on the page — not as a snackbar.
// ============================================================

class PatientDetailErrorBody extends StatelessWidget {
  const PatientDetailErrorBody({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  bool get _isOffline =>
      title == 'No Internet' || title == 'Connection Issue';

  IconData get _icon =>
      _isOffline ? Icons.wifi_off_outlined : Icons.person_off_outlined;

  String get _title {
    if (_isOffline) return 'No Internet';
    if (title == 'Not Found' || title == 'Missing Id') {
      return 'Patient Not Found';
    }
    return title;
  }

  String get _message {
    if (_isOffline) {
      return 'No internet connection. Please try again.';
    }
    if (title == 'Not Found' || title == 'Missing Id') {
      return 'Patient details not found.';
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: PatientDetailPlaceholderBody(
        title: _title,
        message: _message,
        icon: _icon,
      ),
    );
  }
}
