import 'package:permission_handler/permission_handler.dart';
import '../error/exceptions.dart';
import '../constants/app_constants.dart';

class PermissionUtils {
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      throw const PermissionException(AppConstants.cameraPermissionDenied);
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      throw const PermissionException(AppConstants.cameraPermissionDenied);
    }

    return false;
  }

  static Future<bool> requestStoragePermission() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      throw const PermissionException(AppConstants.storagePermissionDenied);
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      throw const PermissionException(AppConstants.storagePermissionDenied);
    }

    return false;
  }

  static Future<bool> checkCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  static Future<bool> checkStoragePermission() async {
    return await Permission.photos.isGranted;
  }
}
