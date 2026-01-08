// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'
    as _i612;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;

import '../features/receipt_capture/data/datasource/camera_data_source.dart'
    as _i364;
import '../features/receipt_capture/data/repository/receipt_capture_repository_impl.dart'
    as _i230;
import '../features/receipt_capture/domain/repository/receipt_capture_repository.dart'
    as _i558;
import '../features/receipt_capture/domain/usecase/capture_receipt_photo_use_case.dart'
    as _i410;
import '../features/receipt_capture/domain/usecase/pick_receipt_from_gallery_use_case.dart'
    as _i1051;
import '../features/receipt_capture/presentation/bloc/receipt_capture_bloc.dart'
    as _i624;
import '../features/receipt_list/presentation/bloc/receipt_list_bloc.dart'
    as _i137;
import '../features/receipt_processing/data/datasource/ocr_data_source.dart'
    as _i781;
import '../features/receipt_processing/data/repository/ocr_repository_impl.dart'
    as _i184;
import '../features/receipt_processing/domain/repository/ocr_repository.dart'
    as _i151;
import '../features/receipt_processing/domain/usecase/extract_text_from_image_use_case.dart'
    as _i788;
import '../features/receipt_processing/domain/util/date_parser.dart' as _i699;
import '../features/receipt_processing/domain/util/merchant_name_parser.dart'
    as _i525;
import '../features/receipt_processing/domain/util/total_amount_parser.dart'
    as _i838;
import '../features/receipt_sharing/data/datasource/pdf_generator_data_source.dart'
    as _i966;
import '../features/receipt_sharing/data/datasource/share_data_source.dart'
    as _i530;
import '../features/receipt_sharing/data/repository/sharing_repository_impl.dart'
    as _i356;
import '../features/receipt_sharing/domain/repository/sharing_repository.dart'
    as _i156;
import '../features/receipt_sharing/domain/usecase/generate_monthly_pdf_use_case.dart'
    as _i686;
import '../features/receipt_sharing/domain/usecase/share_receipts_use_case.dart'
    as _i983;
import '../features/receipt_storage/data/datasource/encryption_data_source.dart'
    as _i324;
import '../features/receipt_storage/data/datasource/receipt_local_data_source.dart'
    as _i101;
import '../features/receipt_storage/data/repository/receipt_repository_impl.dart'
    as _i242;
import '../features/receipt_storage/domain/repository/receipt_repository.dart'
    as _i1008;
import '../features/receipt_storage/domain/usecase/delete_receipt_use_case.dart'
    as _i998;
import '../features/receipt_storage/domain/usecase/get_all_receipts_use_case.dart'
    as _i974;
import '../features/receipt_storage/domain/usecase/get_receipts_by_month_use_case.dart'
    as _i164;
import '../features/receipt_storage/domain/usecase/save_receipt_use_case.dart'
    as _i531;
import '../features/receipt_storage/domain/usecase/search_receipts_use_case.dart'
    as _i459;
import '../features/receipt_storage/domain/usecase/update_receipt_use_case.dart'
    as _i579;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i699.DateParser>(() => _i699.DateParser());
    gh.factory<_i525.MerchantNameParser>(() => _i525.MerchantNameParser());
    gh.factory<_i838.TotalAmountParser>(() => _i838.TotalAmountParser());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.lazySingleton<_i612.TextRecognizer>(() => registerModule.textRecognizer);
    gh.lazySingleton<_i530.ShareDataSource>(() => _i530.ShareDataSourceImpl());
    gh.lazySingleton<_i966.PdfGeneratorDataSource>(
      () => _i966.PdfGeneratorDataSourceImpl(),
    );
    gh.lazySingleton<_i101.ReceiptLocalDataSource>(
      () => _i101.ReceiptLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i364.CameraDataSource>(
      () => _i364.CameraDataSourceImpl(gh<_i183.ImagePicker>()),
    );
    gh.lazySingleton<_i1008.ReceiptRepository>(
      () => _i242.ReceiptRepositoryImpl(gh<_i101.ReceiptLocalDataSource>()),
    );
    gh.lazySingleton<_i156.SharingRepository>(
      () => _i356.SharingRepositoryImpl(
        gh<_i966.PdfGeneratorDataSource>(),
        gh<_i530.ShareDataSource>(),
      ),
    );
    gh.lazySingleton<_i781.OcrDataSource>(
      () => _i781.OcrDataSourceImpl(gh<_i612.TextRecognizer>()),
    );
    gh.lazySingleton<_i324.EncryptionDataSource>(
      () => _i324.EncryptionDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i686.GenerateMonthlyPdfUseCase>(
      () => _i686.GenerateMonthlyPdfUseCase(gh<_i156.SharingRepository>()),
    );
    gh.lazySingleton<_i983.ShareReceiptsUseCase>(
      () => _i983.ShareReceiptsUseCase(gh<_i156.SharingRepository>()),
    );
    gh.lazySingleton<_i558.ReceiptCaptureRepository>(
      () => _i230.ReceiptCaptureRepositoryImpl(gh<_i364.CameraDataSource>()),
    );
    gh.lazySingleton<_i410.CaptureReceiptPhotoUseCase>(
      () => _i410.CaptureReceiptPhotoUseCase(
        gh<_i558.ReceiptCaptureRepository>(),
      ),
    );
    gh.lazySingleton<_i1051.PickReceiptFromGalleryUseCase>(
      () => _i1051.PickReceiptFromGalleryUseCase(
        gh<_i558.ReceiptCaptureRepository>(),
      ),
    );
    gh.lazySingleton<_i998.DeleteReceiptUseCase>(
      () => _i998.DeleteReceiptUseCase(gh<_i1008.ReceiptRepository>()),
    );
    gh.lazySingleton<_i974.GetAllReceiptsUseCase>(
      () => _i974.GetAllReceiptsUseCase(gh<_i1008.ReceiptRepository>()),
    );
    gh.lazySingleton<_i531.SaveReceiptUseCase>(
      () => _i531.SaveReceiptUseCase(gh<_i1008.ReceiptRepository>()),
    );
    gh.lazySingleton<_i459.SearchReceiptsUseCase>(
      () => _i459.SearchReceiptsUseCase(gh<_i1008.ReceiptRepository>()),
    );
    gh.lazySingleton<_i579.UpdateReceiptUseCase>(
      () => _i579.UpdateReceiptUseCase(gh<_i1008.ReceiptRepository>()),
    );
    gh.lazySingleton<_i151.OcrRepository>(
      () => _i184.OcrRepositoryImpl(gh<_i781.OcrDataSource>()),
    );
    gh.lazySingleton<_i164.GetReceiptsByMonthUseCase>(
      () => _i164.GetReceiptsByMonthUseCase(gh<_i974.GetAllReceiptsUseCase>()),
    );
    gh.factory<_i137.ReceiptListBloc>(
      () => _i137.ReceiptListBloc(
        getAllReceipts: gh<_i974.GetAllReceiptsUseCase>(),
        getReceiptsByMonth: gh<_i164.GetReceiptsByMonthUseCase>(),
        searchReceipts: gh<_i459.SearchReceiptsUseCase>(),
        deleteReceipt: gh<_i998.DeleteReceiptUseCase>(),
      ),
    );
    gh.lazySingleton<_i788.ExtractTextFromImageUseCase>(
      () => _i788.ExtractTextFromImageUseCase(
        gh<_i151.OcrRepository>(),
        gh<_i525.MerchantNameParser>(),
        gh<_i838.TotalAmountParser>(),
        gh<_i699.DateParser>(),
      ),
    );
    gh.factory<_i624.ReceiptCaptureBloc>(
      () => _i624.ReceiptCaptureBloc(
        captureReceiptPhoto: gh<_i410.CaptureReceiptPhotoUseCase>(),
        pickReceiptFromGallery: gh<_i1051.PickReceiptFromGalleryUseCase>(),
        extractTextFromImage: gh<_i788.ExtractTextFromImageUseCase>(),
        saveReceipt: gh<_i531.SaveReceiptUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
