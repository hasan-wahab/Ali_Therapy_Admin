import 'package:image_picker/image_picker.dart';

import 'package:ali_therapy_admin/core/utils/app_debug_logger.dart';

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
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
    AppDebugLogger.action(
      where: 'ImagePicker',
      action: file == null ? 'CANCELLED gallery' : 'PICKED gallery',
      detail: file?.name,
    );
    return file;
  }

  /// Open the camera and take one photo.
  /// Returns null if the user cancels.
  Future<XFile?> pickFromCamera({int imageQuality = 80}) async {
    final file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );
    AppDebugLogger.action(
      where: 'ImagePicker',
      action: file == null ? 'CANCELLED camera' : 'PICKED camera',
      detail: file?.name,
    );
    return file;
  }
}
