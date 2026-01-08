import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../model/extracted_text.dart';
import '../util/date_parser.dart';
import '../util/merchant_name_parser.dart';
import '../util/total_amount_parser.dart';
import '../repository/ocr_repository.dart';

@lazySingleton
class ExtractTextFromImageUseCase {
  final OcrRepository repository;
  final MerchantNameParser merchantNameParser;
  final TotalAmountParser totalAmountParser;
  final DateParser dateParser;

  ExtractTextFromImageUseCase(
    this.repository,
    this.merchantNameParser,
    this.totalAmountParser,
    this.dateParser,
  );

  Future<Either<Failure, ExtractedText>> call(ExtractTextParams params) async {
    // Get raw text from repository
    final textResult = await repository.extractTextFromImage(params.imagePath);

    // Apply parsing logic
    return textResult.fold(
      (failure) => Left(failure),
      (rawText) {
        final extractedText = ExtractedText(
          text: rawText,
          merchantName: merchantNameParser.parse(rawText),
          totalAmount: totalAmountParser.parse(rawText),
          date: dateParser.parse(rawText),
        );
        return Right(extractedText);
      },
    );
  }
}

class ExtractTextParams {
  final String imagePath;

  ExtractTextParams(this.imagePath);
}
