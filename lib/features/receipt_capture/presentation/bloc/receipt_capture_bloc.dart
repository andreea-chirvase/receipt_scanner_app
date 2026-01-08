import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/domain/month_year.dart';
import '../../../receipt_processing/domain/usecase/extract_text_from_image_use_case.dart';
import '../../../receipt_storage/domain/model/receipt.dart';
import '../../../receipt_storage/domain/usecase/save_receipt_use_case.dart';
import '../../domain/usecase/capture_receipt_photo_use_case.dart';
import '../../domain/usecase/pick_receipt_from_gallery_use_case.dart';
import 'receipt_capture_event.dart';
import 'receipt_capture_state.dart';

@injectable
class ReceiptCaptureBloc extends Bloc<ReceiptCaptureEvent, ReceiptCaptureState> {
  final CaptureReceiptPhotoUseCase captureReceiptPhoto;
  final PickReceiptFromGalleryUseCase pickReceiptFromGallery;
  final ExtractTextFromImageUseCase extractTextFromImage;
  final SaveReceiptUseCase saveReceipt;

  ReceiptCaptureBloc({
    required this.captureReceiptPhoto,
    required this.pickReceiptFromGallery,
    required this.extractTextFromImage,
    required this.saveReceipt,
  }) : super(ReceiptCaptureInitial()) {
    on<CapturePhotoEvent>(_onCapturePhoto);
    on<PickFromGalleryEvent>(_onPickFromGallery);
    on<ProcessCapturedImage>(_onProcessCapturedImage);
  }

  Future<void> _onCapturePhoto(
    CapturePhotoEvent event,
    Emitter<ReceiptCaptureState> emit,
  ) async {
    emit(const ReceiptCaptureLoading('Capturing photo...'));

    final result = await captureReceiptPhoto();

    result.fold(
      (failure) => emit(ReceiptCaptureError(failure.message)),
      (capturedImage) {
        add(ProcessCapturedImage(capturedImage.imagePath));
      },
    );
  }

  Future<void> _onPickFromGallery(
    PickFromGalleryEvent event,
    Emitter<ReceiptCaptureState> emit,
  ) async {
    emit(const ReceiptCaptureLoading('Loading image...'));

    final result = await pickReceiptFromGallery();

    result.fold(
      (failure) => emit(ReceiptCaptureError(failure.message)),
      (capturedImage) {
        add(ProcessCapturedImage(capturedImage.imagePath));
      },
    );
  }

  Future<void> _onProcessCapturedImage(
    ProcessCapturedImage event,
    Emitter<ReceiptCaptureState> emit,
  ) async {
    emit(const ReceiptCaptureLoading('Extracting text...'));

    // Extract text using OCR
    final ocrResult = await extractTextFromImage(
      ExtractTextParams(event.imagePath),
    );

    await ocrResult.fold(
      (failure) async {
        // Even if OCR fails, save the receipt with empty text
        emit(const ReceiptCaptureLoading('Saving receipt...'));
        await _saveReceiptWithoutText(event.imagePath, emit);
      },
      (extractedText) async {
        // OCR succeeded, save receipt with extracted text
        emit(const ReceiptCaptureLoading('Saving receipt...'));
        await _saveReceiptWithText(
          event.imagePath,
          extractedText.text,
          extractedText.merchantName,
          extractedText.totalAmount,
          extractedText.date,
          emit,
        );
      },
    );
  }

  Future<void> _saveReceiptWithText(
    String imagePath,
    String extractedText,
    String? merchantName,
    double? totalAmount,
    DateTime? receiptDate,
    Emitter<ReceiptCaptureState> emit,
  ) async {
    final now = DateTime.now();
    final monthYear = receiptDate != null
        ? MonthYear.fromDateTime(receiptDate)
        : MonthYear.fromDateTime(now);

    final receipt = Receipt(
      id: const Uuid().v4(),
      imagePath: imagePath,
      extractedText: extractedText,
      dateCaptured: now,
      dateModified: now,
      monthYear: monthYear,
      merchantName: merchantName,
      totalAmount: totalAmount,
    );

    final result = await saveReceipt(SaveReceiptParams(receipt));

    result.fold(
      (failure) => emit(ReceiptCaptureError(failure.message)),
      (_) => emit(ReceiptCaptureSuccess(receipt.id)),
    );
  }

  Future<void> _saveReceiptWithoutText(
    String imagePath,
    Emitter<ReceiptCaptureState> emit,
  ) async {
    final now = DateTime.now();
    final monthYear = MonthYear.fromDateTime(now);

    final receipt = Receipt(
      id: const Uuid().v4(),
      imagePath: imagePath,
      extractedText: '',
      dateCaptured: now,
      dateModified: now,
      monthYear: monthYear,
    );

    final result = await saveReceipt(SaveReceiptParams(receipt));

    result.fold(
      (failure) => emit(ReceiptCaptureError(failure.message)),
      (_) => emit(ReceiptCaptureSuccess(receipt.id)),
    );
  }
}
