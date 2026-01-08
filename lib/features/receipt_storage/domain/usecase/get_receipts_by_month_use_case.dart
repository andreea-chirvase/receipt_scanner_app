import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../core/error/failures.dart';
import '../model/receipt.dart';
import 'get_all_receipts_use_case.dart';

@lazySingleton
class GetReceiptsByMonthUseCase {
  final GetAllReceiptsUseCase getAllReceiptsUseCase;

  GetReceiptsByMonthUseCase(this.getAllReceiptsUseCase);

  Future<Either<Failure, List<Receipt>>> call(GetReceiptsByMonthParams params) async {
    final result = await getAllReceiptsUseCase();

    return result.fold(
      (failure) => Left(failure),
      (receipts) {
        final filteredReceipts = receipts
            .where((receipt) => receipt.monthYear == params.monthYear)
            .toList();
        return Right(filteredReceipts);
      },
    );
  }
}

class GetReceiptsByMonthParams {
  final MonthYear monthYear;

  GetReceiptsByMonthParams(this.monthYear);
}
