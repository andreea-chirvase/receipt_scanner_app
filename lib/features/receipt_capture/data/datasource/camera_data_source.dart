import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class CameraDataSource {
  Future<String> capturePhoto();
  Future<String> pickFromGallery();
}

@LazySingleton(as: CameraDataSource)
class CameraDataSourceImpl implements CameraDataSource {
  final ImagePicker _imagePicker;

  CameraDataSourceImpl(this._imagePicker);

  @override
  Future<String> capturePhoto() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: AppConstants.imageQuality,
      );

      if (photo == null) {
        throw CameraException('User cancelled photo capture');
      }

      return await _processAndSaveImage(photo.path);
    } catch (e) {
      if (e is CameraException) rethrow;
      throw CameraException('Failed to capture photo: $e');
    }
  }

  @override
  Future<String> pickFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: AppConstants.imageQuality,
      );

      if (image == null) {
        throw CameraException('User cancelled image selection');
      }

      return await _processAndSaveImage(image.path);
    } catch (e) {
      if (e is CameraException) rethrow;
      throw CameraException('Failed to pick image from gallery: $e');
    }
  }

  Future<String> _processAndSaveImage(String sourcePath) async {
    try {
      // Read the image
      final sourceFile = File(sourcePath);
      final bytes = await sourceFile.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image == null) {
        throw CameraException('Failed to decode image');
      }

      // Compress if needed (max width defined in constants)
      img.Image processedImage = image;
      if (image.width > AppConstants.imageMaxWidth) {
        processedImage = img.copyResize(
          image,
          width: AppConstants.imageMaxWidth,
        );
      }

      // Get app documents directory
      final directory = await getApplicationDocumentsDirectory();
      final receiptsDir = Directory(path.join(directory.path, 'receipts'));
      if (!await receiptsDir.exists()) {
        await receiptsDir.create(recursive: true);
      }

      // Generate unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'receipt_$timestamp.jpg';
      final filePath = path.join(receiptsDir.path, fileName);

      // Save compressed image
      final compressedBytes = img.encodeJpg(
        processedImage,
        quality: AppConstants.imageQuality,
      );
      await File(filePath).writeAsBytes(compressedBytes);

      return filePath;
    } catch (e) {
      throw CameraException('Failed to process and save image: $e');
    }
  }
}
