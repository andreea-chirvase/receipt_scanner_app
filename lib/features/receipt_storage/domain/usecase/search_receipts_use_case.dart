import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../model/receipt.dart';
import '../repository/receipt_repository.dart';

@lazySingleton
class SearchReceiptsUseCase {
  final ReceiptRepository repository;

  SearchReceiptsUseCase(this.repository);

  Future<Either<Failure, List<Receipt>>> call(SearchReceiptsParams params) {
    return repository.searchReceipts(params.query);
  }
}

class SearchReceiptsParams {
  final String query;

  SearchReceiptsParams(this.query);
}
