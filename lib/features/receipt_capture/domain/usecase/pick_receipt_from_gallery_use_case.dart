import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../model/captured_image.dart';
import '../repository/receipt_capture_repository.dart';

@lazySingleton
class PickReceiptFromGalleryUseCase {
  final ReceiptCaptureRepository repository;

  PickReceiptFromGalleryUseCase(this.repository);

  Future<Either<Failure, CapturedImage>> call() {
    return repository.pickReceiptFromGallery();
  }
}
