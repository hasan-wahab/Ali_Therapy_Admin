import 'package:flutter/material.dart';

// ============================================================
// APP COLORS
// ------------------------------------------------------------
// All colors live here so the UI stays consistent.
//
// How to use in a widget:
//   Container(color: AppColors.primary)
//   Text('Hi', style: TextStyle(color: AppColors.textPrimary))
//
// Brand note:
//   Primary teal matches the Ali Therapy doctor app.
// ============================================================

class AppColors {
  AppColors._(); // cannot create objects of this class

  // ----------------------------------------------------------
  // BRAND / PRIMARY
  // ----------------------------------------------------------

  /// Main brand color (buttons, AppBar, links).
  static const Color primary = Color.fromRGBO(7, 169, 150, 1);

  /// Slightly darker primary (pressed button state).
  static const Color primaryDark = Color(0xFF068F80);

  /// Soft tint of primary (chips, selected tiles, soft bg).
  static const Color primaryLight = Color.fromRGBO(231, 242, 241, 1);

  /// Secondary accent (use sparingly).
  static const Color secondary = Color(0xFF546E7A);

  // ----------------------------------------------------------
  // BACKGROUNDS
  // ----------------------------------------------------------

  /// Default scaffold / page background.
  static const Color background = Color(0xFFF8F9FA);

  /// Cards, dialogs, bottom sheets.
  static const Color surface = Colors.white;

  /// Soft gray section background.
  static const Color sectionBg = Color(0xFFF2F2F2);

  /// Soft chip / table header background.
  static const Color softGray = Color(0xFFF5F5F5);

  // ----------------------------------------------------------
  // TEXT
  // ----------------------------------------------------------

  /// Main body / title text.
  static const Color textPrimary = Color(0xFF212121);

  /// Secondary / less important text.
  static const Color textSecondary = Color.fromRGBO(0, 0, 0, 0.5);

  /// Labels, hints, muted captions.
  static const Color textMuted = Color(0xFF9E9E9E);

  /// Text on top of primary buttons.
  static const Color textOnPrimary = Colors.white;

  // ----------------------------------------------------------
  // BORDER / DIVIDER / ICONS
  // ----------------------------------------------------------

  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color icon = Color(0xFF424242);
  static const Color iconOnPrimary = Colors.white;

  // ----------------------------------------------------------
  // STATUS COLORS
  // ----------------------------------------------------------

  /// Error / delete / danger.
  static const Color error = Color(0xFFD32F2F);

  /// Soft red background (error chips).
  static const Color errorSoft = Color(0xFFFFEBEE);

  /// Success / completed.
  static const Color success = Color(0xFF2E7D32);

  /// Soft green background.
  static const Color successSoft = Color(0xFFE8F5E9);

  /// Warning / pending.
  static const Color warning = Color(0xFFF9A825);

  /// Soft yellow background.
  static const Color warningSoft = Color(0xFFFFF8E1);

  /// Info / links.
  static const Color info = Color(0xFF1046BC);

  /// Soft blue background.
  static const Color infoSoft = Color(0xFFE3F2FD);

  // ----------------------------------------------------------
  // DARK THEME COLORS
  // (used when ThemeMode.dark is active)
  // ----------------------------------------------------------

  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFBDBDBD);
  static const Color borderDark = Color(0xFF2C2C2C);
}
