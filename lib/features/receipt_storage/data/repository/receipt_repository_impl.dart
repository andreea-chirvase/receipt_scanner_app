import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/model/receipt.dart';
import '../../domain/repository/receipt_repository.dart';
import '../datasource/receipt_local_data_source.dart';
import '../model/receipt_model.dart';

@LazySingleton(as: ReceiptRepository)
class ReceiptRepositoryImpl implements ReceiptRepository {
  final ReceiptLocalDataSource localDataSource;

  ReceiptRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> saveReceipt(Receipt receipt) async {
    try {
      final model = ReceiptModelX.fromDomain(receipt);
      await localDataSource.insertReceipt(model);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while saving receipt: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateReceipt(Receipt receipt) async {
    try {
      final model = ReceiptModelX.fromDomain(receipt);
      await localDataSource.updateReceipt(model);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while updating receipt: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReceipt(String id) async {
    try {
      await localDataSource.deleteReceipt(id);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while deleting receipt: $e'));
    }
  }

  @override
  Future<Either<Failure, Receipt?>> getReceiptById(String id) async {
    try {
      final model = await localDataSource.getReceiptById(id);
      return Right(model?.toDomain());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while fetching receipt: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Receipt>>> getAllReceipts() async {
    try {
      final models = await localDataSource.getAllReceipts();
      final receipts = models.map((model) => model.toDomain()).toList();
      return Right(receipts);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while fetching receipts: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Receipt>>> searchReceipts(String query) async {
    try {
      final models = await localDataSource.searchReceipts(query);
      final receipts = models.map((model) => model.toDomain()).toList();
      return Right(receipts);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while searching receipts: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MonthYear>>> getDistinctMonths() async {
    try {
      final monthStrings = await localDataSource.getDistinctMonths();
      final months = monthStrings.map((s) => MonthYear.parse(s)).toList();
      return Right(months);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while fetching months: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> getReceiptCount() async {
    try {
      final count = await localDataSource.getReceiptCount();
      return Right(count);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while counting receipts: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> getReceiptCountByMonth(MonthYear monthYear) async {
    try {
      final count = await localDataSource.getReceiptCountByMonth(monthYear.toIsoString());
      return Right(count);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while counting receipts by month: $e'));
    }
  }

  @override
  Future<Either<Failure, double?>> getTotalAmount() async {
    try {
      final total = await localDataSource.getTotalAmount();
      return Right(total);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while calculating total amount: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Receipt>>> getRecentReceipts(int limit) async {
    try {
      final models = await localDataSource.getRecentReceipts(limit);
      final receipts = models.map((model) => model.toDomain()).toList();
      return Right(receipts);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while fetching recent receipts: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<MonthYear, int>>> getMonthlyReceiptCounts(int monthsCount) async {
    try {
      final stringCounts = await localDataSource.getMonthlyReceiptCounts(monthsCount);
      final counts = stringCounts.map(
        (key, value) => MapEntry(MonthYear.parse(key), value),
      );
      return Right(counts);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(DatabaseFailure('Unexpected error while fetching monthly counts: $e'));
    }
  }
}
