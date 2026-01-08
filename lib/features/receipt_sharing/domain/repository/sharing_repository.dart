import 'package:dartz/dartz.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/failures.dart';
import '../../../receipt_storage/domain/model/receipt.dart';
import '../model/share_package.dart';

abstract class SharingRepository {
  Future<Either<Failure, SharePackage>> generateMonthlyPdf(
    MonthYear monthYear,
    List<Receipt> receipts,
  );
  Future<Either<Failure, void>> sharePackage(SharePackage package);
}
