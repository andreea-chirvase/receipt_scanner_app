class DatabaseConstants {
  static const String databaseName = 'receipts.db';
  static const int databaseVersion = 1;

  // Tables
  static const String receiptsTable = 'receipts';

  // Receipts table columns
  static const String columnId = 'id';
  static const String columnImagePath = 'image_path';
  static const String columnExtractedText = 'extracted_text';
  static const String columnDateCaptured = 'date_captured';
  static const String columnDateModified = 'date_modified';
  static const String columnMonthYear = 'month_year';
  static const String columnMerchantName = 'merchant_name';
  static const String columnTotalAmount = 'total_amount';
  static const String columnCategory = 'category';
  static const String columnNotes = 'notes';

  // Create table SQL
  static const String createReceiptsTable = '''
    CREATE TABLE $receiptsTable (
      $columnId TEXT PRIMARY KEY,
      $columnImagePath TEXT NOT NULL,
      $columnExtractedText TEXT NOT NULL,
      $columnDateCaptured INTEGER NOT NULL,
      $columnDateModified INTEGER NOT NULL,
      $columnMonthYear TEXT NOT NULL,
      $columnMerchantName TEXT,
      $columnTotalAmount REAL,
      $columnCategory TEXT,
      $columnNotes TEXT
    )
  ''';

  // Create indexes
  static const String createMonthYearIndex = '''
    CREATE INDEX idx_month_year ON $receiptsTable($columnMonthYear)
  ''';

  static const String createDateCapturedIndex = '''
    CREATE INDEX idx_date_captured ON $receiptsTable($columnDateCaptured DESC)
  ''';

  static const String createExtractedTextIndex = '''
    CREATE INDEX idx_extracted_text ON $receiptsTable($columnExtractedText)
  ''';
}
