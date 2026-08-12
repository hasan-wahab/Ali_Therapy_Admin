// ============================================================
// VALIDATORS
// ------------------------------------------------------------
// Simple form validators for TextFormField.
//
// Example:
//   TextFormField(
//     validator: Validators.email,
//   )
//
// Tip for beginners:
//   - Return null  → input is VALID
//   - Return text  → input is INVALID (show this error)
// ============================================================

class Validators {
  Validators._();

  /// Field must not be empty.
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Basic email check.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Simple pattern: something@something.something
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Password with minimum length.
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  /// Confirm password must match the original password.
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Phone number: digits only, min length.
  static String? phone(String? value, {int minLength = 10}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < minLength) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
