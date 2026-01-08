import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repository/ocr_repository.dart';
import '../datasource/ocr_data_source.dart';

@LazySingleton(as: OcrRepository)
class OcrRepositoryImpl implements OcrRepository {
  final OcrDataSource ocrDataSource;

  OcrRepositoryImpl(this.ocrDataSource);

  @override
  Future<Either<Failure, String>> extractTextFromImage(String imagePath) async {
    try {
      final text = await ocrDataSource.extractText(imagePath);
      return Right(text);
    } on OcrException catch (e) {
      return Left(OcrFailure(e.message));
    } catch (e) {
      return Left(OcrFailure('Unexpected error during OCR: $e'));
    }
  }
}
