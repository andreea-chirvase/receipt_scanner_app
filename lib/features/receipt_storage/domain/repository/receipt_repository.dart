import 'package:dartz/dartz.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/failures.dart';
import '../model/receipt.dart';

abstract class ReceiptRepository {
  Future<Either<Failure, void>> saveReceipt(Receipt receipt);
  Future<Either<Failure, void>> updateReceipt(Receipt receipt);
  Future<Either<Failure, void>> deleteReceipt(String id);
  Future<Either<Failure, Receipt?>> getReceiptById(String id);
  Future<Either<Failure, List<Receipt>>> getAllReceipts();
  Future<Either<Failure, List<Receipt>>> searchReceipts(String query);
  Future<Either<Failure, List<MonthYear>>> getDistinctMonths();
  Future<Either<Failure, int>> getReceiptCount();
  Future<Either<Failure, int>> getReceiptCountByMonth(MonthYear monthYear);
  Future<Either<Failure, double?>> getTotalAmount();
  Future<Either<Failure, List<Receipt>>> getRecentReceipts(int limit);
  Future<Either<Failure, Map<MonthYear, int>>> getMonthlyReceiptCounts(int monthsCount);
}
