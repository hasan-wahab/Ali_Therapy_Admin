import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/utils/app_device.dart';
import 'package:ali_therapy_admin/core/utils/app_snackbar.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_data.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_print_button.dart';
import 'package:ali_therapy_admin/feature/patient/nfc_card/presentation/widgets/other/nfc_card_view.dart';
import 'package:ali_therapy_admin/feature/patient/patient_detail/presentation/widgets/other/patient_detail_record_refresh_shell.dart';

// ============================================================
// NFC CARD PAGE
// ------------------------------------------------------------
// Records tab → NFC Card.
// Shows the patient identification card (UI-first).
// ============================================================

class NfcCardPage extends StatelessWidget {
  const NfcCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PatientDetailRecordRefreshShell(
      title: 'NFC Card',
      builder: (context, detail) {
        final data = NfcCardData.fromProfile(detail.profile);
        final isTablet = AppDevice.isTablet(context);
        final hPad = isTablet
            ? (AppDevice.isLandscape(context) ? 40.w : 48.w)
            : 16.w;
        final maxWidth = isTablet ? 520.w : double.infinity;

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              padding: EdgeInsets.fromLTRB(hPad, 24.h, hPad, 24.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: Column(
                      children: [
                        NfcCardView(data: data),
                        SizedBox(height: 20.h),
                        NfcCardPrintButton(
                          onTap: () => AppSnackbar.info(
                            context,
                            'Print Patient Card coming soon',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
