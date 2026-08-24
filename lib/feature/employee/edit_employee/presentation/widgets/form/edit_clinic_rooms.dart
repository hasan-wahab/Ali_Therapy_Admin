// ============================================================
// EDIT CLINIC ROOMS
// ------------------------------------------------------------
// Room dropdown depends on the selected clinic (User Details step).
// Clinic 1 / Clinic 2 → Clinic, Office (separate options)
// Corporate           → Clinic
// Clinic 3 (Neuro and Stroke) → Room 1–5 + Office + Treatment Hall + Reception
// ============================================================

class EditClinicRooms {
  EditClinicRooms._();

  static const clinic = 'Clinic';
  static const office = 'Office';

  static const clinic1And2Rooms = [clinic, office];

  static const corporateRooms = [clinic];

  static const clinic3Rooms = [
    'Room 1',
    'Room 2',
    'Room 3',
    'Room 4',
    'Room 5',
    office,
    'Treatment Hall',
    'Reception',
  ];

  /// Room list for the selected clinic. Empty until a clinic is chosen.
  static List<String> roomsFor(String clinicName, {String current = ''}) {
    if (clinicName.trim().isEmpty) return const [];

    final names = List<String>.from(_mappedRooms(clinicName));
    final canonicalCurrent = canonical(clinicName, current);
    if (canonicalCurrent.isNotEmpty && !names.contains(canonicalCurrent)) {
      names.insert(0, canonicalCurrent);
    }
    return names;
  }

  /// Match API room text to the label shown in the dropdown.
  static String canonical(String clinicName, String current) {
    final wanted = current.trim().toLowerCase();
    if (wanted.isEmpty) return '';
    for (final name in _mappedRooms(clinicName)) {
      if (name.toLowerCase() == wanted) return name;
    }
    return current.trim();
  }

  static List<String> _mappedRooms(String clinicName) {
    if (_isClinic3(clinicName)) return clinic3Rooms;
    if (_isCorporate(clinicName)) return corporateRooms;
    if (_isClinic1Or2(clinicName)) return clinic1And2Rooms;
    return const [];
  }

  static bool _isCorporate(String clinicName) {
    return _normalize(clinicName).contains('corporate');
  }

  static bool _isClinic3(String clinicName) {
    final name = _normalize(clinicName);
    if (name.contains('clinic 3')) return true;
    final isNeuro = name.contains('neuro') || name.contains('nero');
    final isStroke = name.contains('stroke') || name.contains('strocke');
    return isNeuro && isStroke;
  }

  static bool _isClinic1Or2(String clinicName) {
    final name = _normalize(clinicName);
    if (_isClinic3(clinicName)) return false;
    return name.contains('clinic 1') || name.contains('clinic 2');
  }

  static String _normalize(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }
}
