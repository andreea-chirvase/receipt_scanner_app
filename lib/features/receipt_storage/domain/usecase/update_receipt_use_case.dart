import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../model/receipt.dart';
import '../repository/receipt_repository.dart';

@lazySingleton
class UpdateReceiptUseCase {
  final ReceiptRepository repository;

  UpdateReceiptUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateReceiptParams params) {
    return repository.updateReceipt(params.receipt);
  }
}

class UpdateReceiptParams {
  final Receipt receipt;

  UpdateReceiptParams(this.receipt);
}
