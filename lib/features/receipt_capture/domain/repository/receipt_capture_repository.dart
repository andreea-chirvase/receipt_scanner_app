import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../model/captured_image.dart';

abstract class ReceiptCaptureRepository {
  Future<Either<Failure, CapturedImage>> captureReceiptPhoto();
  Future<Either<Failure, CapturedImage>> pickReceiptFromGallery();
}
