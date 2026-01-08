import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;
import '../constants/app_constants.dart';

class FileUtils {
  static const _uuid = Uuid();

  static Future<String> getReceiptImagesDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory(path.join(appDir.path, AppConstants.receiptImagesFolder));

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    return imagesDir.path;
  }

  static Future<String> saveImage(String sourcePath) async {
    final imagesDir = await getReceiptImagesDirectory();
    final fileName = '${_uuid.v4()}.jpg';
    final targetPath = path.join(imagesDir, fileName);

    final sourceFile = File(sourcePath);
    final imageBytes = await sourceFile.readAsBytes();

    final compressedBytes = await compressImage(imageBytes);

    await File(targetPath).writeAsBytes(compressedBytes);

    return targetPath;
  }

  static Future<Uint8List> compressImage(Uint8List imageBytes) async {
    final image = img.decodeImage(imageBytes);

    if (image == null) {
      return imageBytes;
    }

    final resized = img.copyResize(
      image,
      width: image.width > AppConstants.imageMaxWidth
          ? AppConstants.imageMaxWidth
          : image.width,
    );

    return Uint8List.fromList(
      img.encodeJpg(resized, quality: AppConstants.imageQuality),
    );
  }

  static Future<void> deleteImage(String imagePath) async {
    final file = File(imagePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  static String getFileName(String filePath) {
    return path.basename(filePath);
  }

  static Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      return await file.length();
    }
    return 0;
  }
}
