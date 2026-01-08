class AppConstants {
  static const String appName = 'Receipt Scanner';
  static const String appVersion = '1.0.0';

  // Storage
  static const String receiptImagesFolder = 'receipt_images';
  static const String encryptionKeyName = 'receipt_encryption_key';

  // Image compression
  static const int imageMaxWidth = 800;
  static const int imageQuality = 85;

  // Pagination
  static const int receiptsPerPage = 20;
  static const int recentReceiptsCount = 5;

  // Charts
  static const int monthsToShowInChart = 6;

  // Date formats
  static const String dateFormatFull = 'MMM dd, yyyy';
  static const String dateFormatMonth = 'MMMM yyyy';
  static const String dateFormatMonthYear = 'yyyy-MM';

  // Error messages
  static const String cameraPermissionDenied = 'Camera permission denied. Please enable it in settings.';
  static const String storagePermissionDenied = 'Storage permission denied. Please enable it in settings.';
  static const String cameraError = 'Failed to access camera. Please try again.';
  static const String ocrError = 'Failed to extract text from receipt. The receipt was saved without text.';
  static const String databaseError = 'Failed to save receipt. Please try again.';
  static const String unexpectedError = 'An unexpected error occurred. Please try again.';
}
