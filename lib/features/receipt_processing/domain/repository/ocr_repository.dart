import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class OcrRepository {
  Future<Either<Failure, String>> extractTextFromImage(String imagePath);
}
