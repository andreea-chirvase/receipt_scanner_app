import 'package:equatable/equatable.dart';

abstract class ReceiptCaptureEvent extends Equatable {
  const ReceiptCaptureEvent();

  @override
  List<Object?> get props => [];
}

class CapturePhotoEvent extends ReceiptCaptureEvent {}

class PickFromGalleryEvent extends ReceiptCaptureEvent {}

class ProcessCapturedImage extends ReceiptCaptureEvent {
  final String imagePath;

  const ProcessCapturedImage(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}
