import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/failures.dart';
import '../../../receipt_storage/domain/model/receipt.dart';
import '../model/share_package.dart';
import '../repository/sharing_repository.dart';

@lazySingleton
class GenerateMonthlyPdfUseCase {
  final SharingRepository repository;

  GenerateMonthlyPdfUseCase(this.repository);

  Future<Either<Failure, SharePackage>> call(GenerateMonthlyPdfParams params) {
    return repository.generateMonthlyPdf(params.monthYear, params.receipts);
  }
}

class GenerateMonthlyPdfParams {
  final MonthYear monthYear;
  final List<Receipt> receipts;

  GenerateMonthlyPdfParams({
    required this.monthYear,
    required this.receipts,
  });
}
