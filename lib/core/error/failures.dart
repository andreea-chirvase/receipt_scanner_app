import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CameraFailure extends Failure {
  const CameraFailure(super.message);
}

class GalleryFailure extends Failure {
  const GalleryFailure(super.message);
}

class OcrFailure extends Failure {
  const OcrFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

class EncryptionFailure extends Failure {
  const EncryptionFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class PdfGenerationFailure extends Failure {
  const PdfGenerationFailure(super.message);
}

class SharingFailure extends Failure {
  const SharingFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
