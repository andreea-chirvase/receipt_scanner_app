import 'dart:convert';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class EncryptionDataSource {
  Future<String> getOrCreateEncryptionKey();
  Future<void> deleteEncryptionKey();
}

@LazySingleton(as: EncryptionDataSource)
class EncryptionDataSourceImpl implements EncryptionDataSource {
  final FlutterSecureStorage _secureStorage;

  EncryptionDataSourceImpl(this._secureStorage);

  @override
  Future<String> getOrCreateEncryptionKey() async {
    try {
      String? key = await _secureStorage.read(
        key: AppConstants.encryptionKeyName,
      );

      if (key == null) {
        key = _generateEncryptionKey();
        await _secureStorage.write(
          key: AppConstants.encryptionKeyName,
          value: key,
        );
      }

      return key;
    } catch (e) {
      throw EncryptionException('Failed to get or create encryption key: $e');
    }
  }

  @override
  Future<void> deleteEncryptionKey() async {
    try {
      await _secureStorage.delete(key: AppConstants.encryptionKeyName);
    } catch (e) {
      throw EncryptionException('Failed to delete encryption key: $e');
    }
  }

  String _generateEncryptionKey() {
    final random = Random.secure();
    final values = List<int>.generate(32, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }
}
