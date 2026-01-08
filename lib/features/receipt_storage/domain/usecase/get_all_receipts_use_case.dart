import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../model/receipt.dart';
import '../repository/receipt_repository.dart';

@lazySingleton
class GetAllReceiptsUseCase {
  final ReceiptRepository repository;

  GetAllReceiptsUseCase(this.repository);

  Future<Either<Failure, List<Receipt>>> call() {
    return repository.getAllReceipts();
  }
}
