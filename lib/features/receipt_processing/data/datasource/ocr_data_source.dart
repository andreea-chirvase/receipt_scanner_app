import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';

abstract class OcrDataSource {
  Future<String> extractText(String imagePath);
}

@LazySingleton(as: OcrDataSource)
class OcrDataSourceImpl implements OcrDataSource {
  final TextRecognizer _textRecognizer;

  OcrDataSourceImpl(this._textRecognizer);

  @override
  Future<String> extractText(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      if (recognizedText.text.isEmpty) {
        throw OcrException('No text found in image');
      }

      return recognizedText.text;
    } catch (e) {
      if (e is OcrException) rethrow;
      throw OcrException('Failed to extract text from image: $e');
    }
  }
}
