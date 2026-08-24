import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ali_therapy_admin/core/theme/app_colors.dart';
import 'package:ali_therapy_admin/core/theme/app_text_styles.dart';

// ============================================================
// APP CUPERTINO DATE PICKER (shared — whole app)
// ------------------------------------------------------------
// Scrolling month / day / year wheels (CupertinoDatePicker).
// Use this everywhere a date is picked — do not call showDatePicker.
//
// Example:
//   final picked = await showAppCupertinoDatePicker(context: context);
// ============================================================

class AppCupertinoDatePickerSheet extends StatefulWidget {
  const AppCupertinoDatePickerSheet({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<AppCupertinoDatePickerSheet> createState() =>
      _AppCupertinoDatePickerSheetState();
}

class _AppCupertinoDatePickerSheetState
    extends State<AppCupertinoDatePickerSheet> {
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    // Bottom sheet fills from the bottom up to the screen center.
    final sheetHeight = MediaQuery.sizeOf(context).height * 0.5;

    return SizedBox(
      height: sheetHeight,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(_selected),
                      child: Text(
                        'Done',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    brightness: Brightness.light,
                    primaryColor: AppColors.primary,
                  ),
                  child: CupertinoDatePicker(
                    key: ValueKey(widget.initialDate),
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.mdy,
                    initialDateTime: widget.initialDate,
                    minimumDate: widget.firstDate,
                    maximumDate: widget.lastDate,
                    itemExtent: 40.h,
                    onDateTimeChanged: (value) {
                      _selected = DateTime(value.year, value.month, value.day);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens the shared scrolling date picker. Returns null if cancelled.
/// Default selected date is today when [initialDate] is not passed.
Future<DateTime?> showAppCupertinoDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  final today = _dateOnly(DateTime.now());
  final min = _dateOnly(firstDate ?? DateTime(2000));
  final max = _dateOnly(lastDate ?? DateTime(today.year + 5, 12, 31));
  var initial = _dateOnly(initialDate ?? today);

  if (initial.isBefore(min)) initial = min;
  if (initial.isAfter(max)) initial = max;

  return showModalBottomSheet<DateTime>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AppCupertinoDatePickerSheet(
      initialDate: initial,
      firstDate: min,
      lastDate: max,
    ),
  );
}

DateTime _dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);
