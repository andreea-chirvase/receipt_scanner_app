import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../receipt_storage/domain/model/receipt.dart';
import '../../domain/model/share_package.dart';
import '../../domain/repository/sharing_repository.dart';
import '../datasource/pdf_generator_data_source.dart';
import '../datasource/share_data_source.dart';

@LazySingleton(as: SharingRepository)
class SharingRepositoryImpl implements SharingRepository {
  final PdfGeneratorDataSource pdfGenerator;
  final ShareDataSource shareDataSource;

  SharingRepositoryImpl(this.pdfGenerator, this.shareDataSource);

  @override
  Future<Either<Failure, SharePackage>> generateMonthlyPdf(
    MonthYear monthYear,
    List<Receipt> receipts,
  ) async {
    try {
      final pdfPath = await pdfGenerator.generatePdf(monthYear, receipts);

      final package = SharePackage(
        pdfPath: pdfPath,
        monthYear: monthYear,
        receiptCount: receipts.length,
        generatedAt: DateTime.now(),
      );

      return Right(package);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(StorageFailure('Unexpected error generating PDF: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> sharePackage(SharePackage package) async {
    try {
      await shareDataSource.sharePdf(package.pdfPath, package.monthYear);
      return const Right(null);
    } on StorageException catch (e) {
      return Left(StorageFailure(e.message));
    } catch (e) {
      return Left(StorageFailure('Unexpected error sharing PDF: $e'));
    }
  }
}
