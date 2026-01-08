# Receipt Scanner App

A Flutter receipt scanner app showcasing **Clean Architecture**, **SOLID principles**, and modern Flutter development practices.


[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Features

- 📸 **Receipt Capture** - Take photos or select from gallery
- 🔍 **OCR Processing** - Automatic text extraction using Google ML Kit
- 🔐 **Encrypted Storage** - Secure local database with SQLite
- 📋 **Receipt Management** - Browse, search, and organize receipts by month
- 💰 **Smart Parsing** - Automatically extracts merchant name, amount, and date
- 📄 **PDF Export** - Generate and share monthly receipt PDFs
- 🔄 **Offline First** - All processing happens on-device


## Architecture & Design Patterns

This project utilizes industry-standard patterns to ensure a decoupled, maintainable, and highly scalable codebase that remains easy to navigate and test.

- **Clean Architecture** - separation of concerns into three distinct layers:
	- Domain: Core business logic (Models, Use Cases, Repositories interfaces).
	- Data: Implementation of repositories and data sources (DTOs, Mappers, Local/Remote DB).
	- Presentation: UI logic using the BLoC pattern.
- **BLoC Pattern** (Business Logic Component) - Handles state management to ensure a predictable data flow and a clear separation between the UI and business logic.
- **Repository Pattern** - Acts as a mediator between the domain and data layers, providing a clean API for the rest of the app while hiding the complexity of data origin.
- **Use Case Pattern** - Each business action (e.g. GetReceiptsByMonthUseCase) is encapsulated in a single-purpose class, making the app’s capabilities explicit and easy to test.
- **Dependency Injection & SOLID** - Utilizes get_it and injectable to manage dependencies; classes are open for extension but closed for modification (OCP) and rely on abstractions rather than concretions (DIP)

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── di/
│   ├── injection.dart                 # DI configuration
│   └── injection.config.dart          # Generated DI code
│
├── core/                              # Shared utilities
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── database_constants.dart
│   ├── domain/
│   │   └── month_year.dart            # MonthYear value object (Equatable, Comparable)
│   ├── error/
│   │   ├── failures.dart              # Failure types (Either pattern)
│   │   └── exceptions.dart            # Exception types
│   └── utils/
│       ├── date_formatter.dart
│       ├── file_utils.dart
│       └── permission_utils.dart
│
├── app/                               # App-level configuration
│   ├── theme/
│   │   ├── app_theme.dart             # Material 3 theme
│   │   ├── app_colors.dart            # Color palette
│   │   └── app_text_styles.dart       # Typography
│   └── router/
│       ├── app_router.dart            # Navigation configuration
│       └── route_names.dart           # Route constants
│
└── features/                          # Feature modules
    │
    ├── receipt_storage/               # Receipt data persistence
    │   ├── data/
    │   │   ├── datasource/
    │   │   │   ├── receipt_local_data_source.dart
    │   │   │   └── encryption_data_source.dart
    │   │   ├── model/
    │   │   │   └── receipt_model.dart
    │   │   └── repository/
    │   │       └── receipt_repository_impl.dart
    │   └── domain/
    │       ├── model/
    │       │   └── receipt.dart
    │       ├── repository/
    │       │   └── receipt_repository.dart
    │       └── usecase/
    │           ├── save_receipt_use_case.dart
    │           ├── update_receipt_use_case.dart
    │           ├── get_all_receipts_use_case.dart
    │           ├── get_receipts_by_month_use_case.dart
    │           ├── search_receipts_use_case.dart
    │           └── delete_receipt_use_case.dart
    │
    ├── receipt_capture/               # Camera & image capture
    │   ├── data/
    │   │   ├── datasource/
    │   │   │   └── camera_data_source.dart
    │   │   └── repository/
    │   │       └── receipt_capture_repository_impl.dart
    │   ├── domain/
    │   │   ├── model/
    │   │   │   └── captured_image.dart
    │   │   ├── repository/
    │   │   │   └── receipt_capture_repository.dart
    │   │   └── usecase/
    │   │       ├── capture_receipt_photo_use_case.dart
    │   │       └── pick_receipt_from_gallery_use_case.dart
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── receipt_capture_bloc.dart
    │       │   ├── receipt_capture_event.dart
    │       │   └── receipt_capture_state.dart
    │       └── pages/
    │           └── receipt_capture_page.dart
    │
    ├── receipt_processing/            # OCR & text extraction
    │   ├── data/
    │   │   ├── datasource/
    │   │   │   └── ocr_data_source.dart
    │   │   └── repository/
    │   │       └── ocr_repository_impl.dart
    │   └── domain/
    │       ├── model/
    │       │   └── extracted_text.dart
    │       ├── repository/
    │       │   └── ocr_repository.dart
    │       ├── usecase/
    │       │   └── extract_text_from_image_use_case.dart
    │       └── util/
    │           ├── receipt_text_parser.dart
    │           ├── merchant_name_parser.dart
    │           ├── total_amount_parser.dart
    │           └── date_parser.dart
    │
    ├── receipt_sharing/               # PDF generation & sharing
    │   ├── data/
    │   │   ├── datasource/
    │   │   │   ├── pdf_generator_data_source.dart
    │   │   │   └── share_data_source.dart
    │   │   └── repository/
    │   │       └── sharing_repository_impl.dart
    │   └── domain/
    │       ├── model/
    │       │   └── share_package.dart
    │       ├── repository/
    │       │   └── sharing_repository.dart
    │       └── usecase/
    │           ├── generate_monthly_pdf_use_case.dart
    │           └── share_receipts_use_case.dart
    │
    └── receipt_list/                  # Browse & search receipts
        └── presentation/
            ├── bloc/
            │   ├── receipt_list_bloc.dart
            │   ├── receipt_list_event.dart
            │   └── receipt_list_state.dart
            ├── pages/
            │   ├── receipt_list_page.dart
            │   └── receipt_detail_page.dart
            └── widgets/
                ├── receipt_card.dart
                ├── month_section_header.dart
                ├── search_bar_widget.dart
                └── empty_state_widget.dart
```

### Tech Stack

| Category | Technology |
|----------|-----------|
| **State Management** | flutter_bloc, equatable |
| **Dependency Injection** | get_it, injectable |
| **Local Database** | sqflite |
| **Encryption** | flutter_secure_storage |
| **Code Generation** | freezed, json_serializable, injectable_generator |
| **Functional Programming** | dartz (Either type) |
| **Image Processing** | image, image_picker |
| **OCR** | google_mlkit_text_recognition |
| **PDF Generation** | pdf |
| **UI** | Material Design 3, intl |
| **Sharing** | share_plus |
| **Utilities** | uuid, path_provider, path |

## Setup & Installation

### Prerequisites
- Flutter SDK 3.x or higher
- Dart SDK 3.x or higher
- Android Studio / VS Code
- iOS: Xcode (for iOS development)

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/andreea-chirvase/receipt_scanner_app.git
   cd receipt_scanner_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
   This generates:
   - `injection.config.dart` - Dependency injection configuration
   - `*.freezed.dart` - Freezed immutable models
   - `*.g.dart` - JSON serialization code

4. **Run the app**
   ```bash
   # Android
   flutter run

   # iOS
   flutter run -d ios
   ```

### Troubleshooting

**Issue**: "Missing concrete implementations of getter mixin _$ReceiptModel"
- **Solution**: This is an IDE analyzer cache issue. After running `build_runner`, restart your IDE or run "Dart: Restart Analysis Server" (VS Code: Cmd+Shift+P).

**Issue**: "Target of URI doesn't exist: 'injection.config.dart'"
- **Solution**: Run `dart run build_runner build --delete-conflicting-outputs`

## How It Works

### 1. Receipt Capture Flow
```
User taps "Scan Receipt"
    → Opens Camera/Gallery
    → User captures/selects image
    → Image compressed (800px width)
    → Saved to app documents directory
    → Triggers OCR processing
```

### 2. OCR Processing Flow
```
Image saved
    → Google ML Kit processes image
    → Extracts raw text
    → Smart parsing:
        - Merchant name (first line)
        - Total amount (regex patterns)
        - Date (date pattern matching)
    → Returns ExtractedText entity
```

### 3. Receipt Storage Flow
```
ExtractedText received
    → Create Receipt entity with:
        - Generated UUID
        - Image path
        - Extracted text & metadata
        - Current timestamp
        - Month/Year for grouping
    → Repository saves to SQLite
    → Encryption key stored in secure storage
```

### 4. Receipt List Display
```
User opens app
    → Bloc loads all receipts from database
    → Receipts grouped by MonthYear value object
    → Displayed in descending order
    → Pull-to-refresh available
    → Search filters in real-time
    → Share button for monthly PDF export
```

### 5. PDF Export Flow
```
User taps "Share" on month section
    → Bloc triggers PDF generation use case
    → PdfGeneratorDataSource:
        - Creates PDF document
        - Adds receipt images page by page
        - Sets title to "January 2024 Receipts"
    → PDF saved to temporary directory
    → Share dialog opens with PDF file
    → User shares via email/messaging apps
```

## Database Schema

### Receipts Table
```sql
CREATE TABLE receipts (
  id TEXT PRIMARY KEY,              -- UUID
  image_path TEXT NOT NULL,         -- Local file path
  extracted_text TEXT NOT NULL,     -- OCR result
  date_captured INTEGER NOT NULL,   -- Unix timestamp
  date_modified INTEGER NOT NULL,   -- Unix timestamp
  month_year TEXT NOT NULL,         -- Format: "2024-01"
  merchant_name TEXT,               -- Extracted merchant
  total_amount REAL,                -- Extracted amount
  category TEXT,                    -- User category
  notes TEXT                        -- User notes
);

-- Indexes for performance
CREATE INDEX idx_month_year ON receipts(month_year);
CREATE INDEX idx_date_captured ON receipts(date_captured DESC);
CREATE INDEX idx_extracted_text ON receipts(extracted_text);
```

## SOLID Principles Implementation

### Single Responsibility Principle (SRP)
- Each UseCase handles one business operation
- Data sources separated: Camera, OCR, Database, Encryption
- BLoCs handle only presentation logic for their feature

### Open/Closed Principle (OCP)
- Repository interfaces allow swapping implementations
- UseCases enable adding operations without modifying existing code

### Liskov Substitution Principle (LSP)
- All repositories implement well-defined contracts
- Models extend entities without breaking behavior

### Interface Segregation Principle (ISP)
- Small, focused repository interfaces per feature
- Data sources expose only necessary methods

### Dependency Inversion Principle (DIP)
- High-level modules (UseCases) depend on abstractions (Repositories)
- Dependency injection via `get_it` ensures loose coupling

## Future Enhancements
- [ ] Unit & integration tests
- [ ] Dark mode
- [ ] Localization

## Screenshots

<img width="200" alt="image" src="https://github.com/user-attachments/assets/25442e7d-42be-4701-a440-ce52f6debf4e" /> <img width="200" alt="image" src="https://github.com/user-attachments/assets/d90f5703-39dc-4575-9415-b904d42a5050" /> <img width="200" alt="image" src="https://github.com/user-attachments/assets/50357ced-74af-4336-b801-e0feb1d9352c" />

<img width="200" alt="image" src="https://github.com/user-attachments/assets/2300110a-1025-402d-a9b4-42627fe73c86" /> <img width="200" alt="image" src="https://github.com/user-attachments/assets/e78d1688-2aaa-4b27-b584-22f603ad922f" /> <img width="200" alt="image" src="https://github.com/user-attachments/assets/da087fc9-b435-4c42-90a2-657e50fd7b2d" />


## Platform Support

- ✅ Android API 21+
- ✅ iOS 12+

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Built by a senior Android developer, showcasing Clean Architecture and Flutter best practices for portfolio purposes.

---

**Note**: This is an MVP focused on core functionality with receipt scanning, OCR processing, encrypted storage, and PDF export capabilities.
