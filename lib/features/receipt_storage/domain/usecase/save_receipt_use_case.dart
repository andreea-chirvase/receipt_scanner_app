import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../model/receipt.dart';
import '../repository/receipt_repository.dart';

@lazySingleton
class SaveReceiptUseCase {
  final ReceiptRepository repository;

  SaveReceiptUseCase(this.repository);

  Future<Either<Failure, void>> call(SaveReceiptParams params) {
    return repository.saveReceipt(params.receipt);
  }
}

class SaveReceiptParams {
  final Receipt receipt;

  SaveReceiptParams(this.receipt);
}
