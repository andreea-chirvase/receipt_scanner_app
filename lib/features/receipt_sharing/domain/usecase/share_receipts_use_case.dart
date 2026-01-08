import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../model/share_package.dart';
import '../repository/sharing_repository.dart';

@lazySingleton
class ShareReceiptsUseCase {
  final SharingRepository repository;

  ShareReceiptsUseCase(this.repository);

  Future<Either<Failure, void>> call(ShareReceiptsParams params) {
    return repository.sharePackage(params.package);
  }
}

class ShareReceiptsParams {
  final SharePackage package;

  ShareReceiptsParams(this.package);
}
