import 'package:image_picker/image_picker.dart';

/// ============================================================
/// IMAGE PICKER SERVICE
/// ------------------------------------------------------------
/// Tiny wrapper around image_picker package.
/// Keeps gallery / camera logic in one place.
/// ============================================================

class ImagePickerService {
  final ImagePicker _picker;

  ImagePickerService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  /// Open the phone gallery and pick one image.
  /// Returns null if the user cancels.
  Future<XFile?> pickFromGallery({int imageQuality = 80}) async {
    return _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
  }

  /// Open the camera and take one photo.
  /// Returns null if the user cancels.
  Future<XFile?> pickFromCamera({int imageQuality = 80}) async {
    return _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );
  }
}
