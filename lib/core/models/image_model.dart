//============================================================================
//! IMAGE MODEL
//============================================================================

class ImageModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  /// Local file path when isLocal == true.
  /// Public URL when isLocal == false.
  final String path;

  /// Storage path inside Supabase.
  ///
  /// Example:
  /// properties/abc123/photo.jpg
  ///
  /// Null for newly selected local images.
  final String? storagePath;

  /// True if selected from the device.
  /// False if already stored in Supabase.
  final bool isLocal;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ImageModel({
    required this.path,
    required this.isLocal,
    this.storagePath,
  });
}
