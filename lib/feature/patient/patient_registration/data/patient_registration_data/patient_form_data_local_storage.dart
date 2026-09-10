import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:ali_therapy_admin/core/utils/app_debug_logger.dart';
import 'package:ali_therapy_admin/feature/patient/patient_registration/data/patient_registration_data/models/patient_form_data_model.dart';

// ============================================================
// PATIENT FORM DATA LOCAL STORAGE
// ------------------------------------------------------------
// Saves GET patients/form-data on first Create Patient open.
// Later opens reuse this — dropdowns do not change per visit.
// ============================================================

class PatientFormDataLocalStorage {
  PatientFormDataLocalStorage(this._prefs);

  final SharedPreferences _prefs;

  static const String _key = 'patient_form_data_json';

  PatientFormDataModel? _memory;

  PatientFormDataModel? read() {
    if (_memory != null && _memory!.hasDropdowns) return _memory;

    final raw = _prefs.getString(_key);
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final model = PatientFormDataModel.fromJson(
        Map<String, dynamic>.from(decoded),
      );
      if (!model.hasDropdowns) return null;
      _memory = model;
      AppDebugLogger.local(
        action: 'READ',
        key: _key,
        value: 'cached form-data (${model.cities.length} cities)',
      );
      return model;
    } catch (_) {
      return null;
    }
  }

  Future<void> save(PatientFormDataModel model) async {
    if (!model.hasDropdowns) return;
    _memory = model;
    await _prefs.setString(_key, jsonEncode(model.toJson()));
    AppDebugLogger.local(
      action: 'SAVE',
      key: _key,
      value: 'form-data cached (${model.cities.length} cities)',
    );
  }

  Future<void> clear() async {
    _memory = null;
    await _prefs.remove(_key);
    AppDebugLogger.local(
      action: 'CLEAR',
      key: _key,
      value: 'form-data cache removed',
    );
  }
}
