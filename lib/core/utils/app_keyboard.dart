import 'package:flutter/material.dart';

// ============================================================
// APP KEYBOARD
// ------------------------------------------------------------
// Dismisses the soft keyboard (unfocus current field).
// Call before actions / loading so the UI is not covered.
// ============================================================

class AppKeyboard {
  AppKeyboard._();

  /// Closes the keyboard if a text field is focused.
  static void dismiss() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
