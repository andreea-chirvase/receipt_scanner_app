import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/model/captured_image.dart';
import '../../domain/repository/receipt_capture_repository.dart';
import '../datasource/camera_data_source.dart';

@LazySingleton(as: ReceiptCaptureRepository)
class ReceiptCaptureRepositoryImpl implements ReceiptCaptureRepository {
  final CameraDataSource cameraDataSource;

  ReceiptCaptureRepositoryImpl(this.cameraDataSource);

  @override
  Future<Either<Failure, CapturedImage>> captureReceiptPhoto() async {
    try {
      final imagePath = await cameraDataSource.capturePhoto();
      final capturedImage = CapturedImage(
        imagePath: imagePath,
        captureTime: DateTime.now(),
      );
      return Right(capturedImage);
    } on CameraException catch (e) {
      return Left(CameraFailure(e.message));
    } catch (e) {
      return Left(CameraFailure('Unexpected error while capturing photo: $e'));
    }
  }

  @override
  Future<Either<Failure, CapturedImage>> pickReceiptFromGallery() async {
    try {
      final imagePath = await cameraDataSource.pickFromGallery();
      final capturedImage = CapturedImage(
        imagePath: imagePath,
        captureTime: DateTime.now(),
      );
      return Right(capturedImage);
    } on CameraException catch (e) {
      return Left(CameraFailure(e.message));
    } catch (e) {
      return Left(CameraFailure('Unexpected error while picking image: $e'));
    }
  }
}
