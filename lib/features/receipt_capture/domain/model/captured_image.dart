import 'package:equatable/equatable.dart';

class CapturedImage extends Equatable {
  final String imagePath;
  final DateTime captureTime;

  const CapturedImage({
    required this.imagePath,
    required this.captureTime,
  });

  @override
  List<Object?> get props => [imagePath, captureTime];
}
