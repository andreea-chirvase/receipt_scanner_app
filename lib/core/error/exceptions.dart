class CameraException implements Exception {
  final String message;
  const CameraException(this.message);

  @override
  String toString() => 'CameraException: $message';
}

class GalleryException implements Exception {
  final String message;
  const GalleryException(this.message);

  @override
  String toString() => 'GalleryException: $message';
}

class OcrException implements Exception {
  final String message;
  const OcrException(this.message);

  @override
  String toString() => 'OcrException: $message';
}

class DatabaseException implements Exception {
  final String message;
  const DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}

class StorageException implements Exception {
  final String message;
  const StorageException(this.message);

  @override
  String toString() => 'StorageException: $message';
}

class EncryptionException implements Exception {
  final String message;
  const EncryptionException(this.message);

  @override
  String toString() => 'EncryptionException: $message';
}

class PermissionException implements Exception {
  final String message;
  const PermissionException(this.message);

  @override
  String toString() => 'PermissionException: $message';
}

class PdfGenerationException implements Exception {
  final String message;
  const PdfGenerationException(this.message);

  @override
  String toString() => 'PdfGenerationException: $message';
}

class SharingException implements Exception {
  final String message;
  const SharingException(this.message);

  @override
  String toString() => 'SharingException: $message';
}
