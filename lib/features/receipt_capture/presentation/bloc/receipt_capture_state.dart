import 'package:equatable/equatable.dart';

abstract class ReceiptCaptureState extends Equatable {
  const ReceiptCaptureState();

  @override
  List<Object?> get props => [];
}

class ReceiptCaptureInitial extends ReceiptCaptureState {}

class ReceiptCaptureLoading extends ReceiptCaptureState {
  final String message;

  const ReceiptCaptureLoading([this.message = 'Processing...']);

  @override
  List<Object?> get props => [message];
}

class ReceiptCaptureSuccess extends ReceiptCaptureState {
  final String receiptId;

  const ReceiptCaptureSuccess(this.receiptId);

  @override
  List<Object?> get props => [receiptId];
}

class ReceiptCaptureError extends ReceiptCaptureState {
  final String message;

  const ReceiptCaptureError(this.message);

  @override
  List<Object?> get props => [message];
}
