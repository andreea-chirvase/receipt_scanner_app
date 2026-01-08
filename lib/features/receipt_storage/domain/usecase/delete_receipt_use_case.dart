import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../repository/receipt_repository.dart';

@lazySingleton
class DeleteReceiptUseCase {
  final ReceiptRepository repository;

  DeleteReceiptUseCase(this.repository);

  Future<Either<Failure, void>> call(DeleteReceiptParams params) {
    return repository.deleteReceipt(params.id);
  }
}

class DeleteReceiptParams {
  final String id;

  DeleteReceiptParams(this.id);
}
