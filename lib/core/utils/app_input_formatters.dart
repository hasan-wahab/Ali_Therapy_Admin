import 'package:flutter/services.dart';

// ============================================================
// APP INPUT FORMATTERS
// ------------------------------------------------------------
// Shared typing limits for phone / CNIC / passport.
// Pakistan:
//   Phone    → 11 digits (03XXXXXXXXX)
//   CNIC     → 13 digits with dashes: 12345-1234567-1
//   Passport → 9 chars (2 letters + 7 digits)
// ============================================================

class AppInputFormatters {
  AppInputFormatters._();

  static const int phoneDigits = 11;
  static const int cnicDigits = 13;
  static const int passportLength = 9;

  static final List<TextInputFormatter> phone = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(phoneDigits),
  ];

  static final List<TextInputFormatter> cnic = [
    FilteringTextInputFormatter.digitsOnly,
    _CnicDashFormatter(),
  ];

  static final List<TextInputFormatter> passport = [
    FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
    LengthLimitingTextInputFormatter(passportLength),
    TextInputFormatter.withFunction((oldValue, newValue) {
      return newValue.copyWith(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection,
      );
    }),
  ];

  static final List<TextInputFormatter> age = [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(3),
  ];

  static String digitsOnly(String raw, {int? max}) {
    var digits = raw.replaceAll(RegExp(r'\D'), '');
    if (max != null && digits.length > max) {
      digits = digits.substring(0, max);
    }
    return digits;
  }

  /// 13 digits → 12345-1234567-1
  static String formatCnic(String raw) {
    final digits = digitsOnly(raw, max: cnicDigits);
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i == 5 || i == 12) buffer.write('-');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  static String formatPhone(String raw) {
    return digitsOnly(raw, max: phoneDigits);
  }

  static String formatPassport(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();
    if (cleaned.length <= passportLength) return cleaned;
    return cleaned.substring(0, passportLength);
  }

  static bool isCompletePhone(String raw) {
    return digitsOnly(raw).length == phoneDigits;
  }

  static bool isCompleteCnic(String raw) {
    return digitsOnly(raw).length == cnicDigits;
  }

  static bool isCompletePassport(String raw) {
    return formatPassport(raw).length == passportLength;
  }
}

/// Inserts CNIC dashes while typing: #####-#######-#
class _CnicDashFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final formatted = AppInputFormatters.formatCnic(newValue.text);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
