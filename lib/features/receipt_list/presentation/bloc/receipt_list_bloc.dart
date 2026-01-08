import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/domain/month_year.dart';
import '../../../receipt_storage/domain/model/receipt.dart';
import '../../../receipt_storage/domain/usecase/delete_receipt_use_case.dart';
import '../../../receipt_storage/domain/usecase/get_all_receipts_use_case.dart';
import '../../../receipt_storage/domain/usecase/get_receipts_by_month_use_case.dart';
import '../../../receipt_storage/domain/usecase/search_receipts_use_case.dart' as use_cases;
import 'receipt_list_event.dart';
import 'receipt_list_state.dart';

@injectable
class ReceiptListBloc extends Bloc<ReceiptListEvent, ReceiptListState> {
  final GetAllReceiptsUseCase getAllReceipts;
  final GetReceiptsByMonthUseCase getReceiptsByMonth;
  final use_cases.SearchReceiptsUseCase searchReceipts;
  final DeleteReceiptUseCase deleteReceipt;

  ReceiptListBloc({
    required this.getAllReceipts,
    required this.getReceiptsByMonth,
    required this.searchReceipts,
    required this.deleteReceipt,
  }) : super(ReceiptListInitial()) {
    on<LoadAllReceipts>(_onLoadAllReceipts);
    on<LoadReceiptsByMonth>(_onLoadReceiptsByMonth);
    on<SearchReceiptsEvent>(_onSearchReceipts);
    on<DeleteReceiptEvent>(_onDeleteReceipt);
    on<RefreshReceipts>(_onRefreshReceipts);
  }

  Future<void> _onLoadAllReceipts(
    LoadAllReceipts event,
    Emitter<ReceiptListState> emit,
  ) async {
    emit(ReceiptListLoading());

    final result = await getAllReceipts();

    result.fold(
      (failure) => emit(ReceiptListError(failure.message)),
      (receipts) {
        final grouped = _groupReceiptsByMonth(receipts);
        emit(ReceiptListLoaded(receipts: receipts, groupedByMonth: grouped));
      },
    );
  }

  Future<void> _onLoadReceiptsByMonth(
    LoadReceiptsByMonth event,
    Emitter<ReceiptListState> emit,
  ) async {
    emit(ReceiptListLoading());

    final result = await getReceiptsByMonth(
      GetReceiptsByMonthParams(event.monthYear),
    );

    result.fold(
      (failure) => emit(ReceiptListError(failure.message)),
      (receipts) {
        final grouped = _groupReceiptsByMonth(receipts);
        emit(ReceiptListLoaded(receipts: receipts, groupedByMonth: grouped));
      },
    );
  }

  Future<void> _onSearchReceipts(
    SearchReceiptsEvent event,
    Emitter<ReceiptListState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(LoadAllReceipts());
      return;
    }

    emit(ReceiptListLoading());

    final result = await searchReceipts(
      use_cases.SearchReceiptsParams(event.query),
    );

    result.fold(
      (failure) => emit(ReceiptListError(failure.message)),
      (receipts) {
        final grouped = _groupReceiptsByMonth(receipts);
        emit(ReceiptListLoaded(receipts: receipts, groupedByMonth: grouped));
      },
    );
  }

  Future<void> _onDeleteReceipt(
    DeleteReceiptEvent event,
    Emitter<ReceiptListState> emit,
  ) async {
    emit(ReceiptDeleting(event.receiptId));

    final result = await deleteReceipt(
      DeleteReceiptParams(event.receiptId),
    );

    result.fold(
      (failure) => emit(ReceiptListError(failure.message)),
      (_) {
        emit(ReceiptDeleted(event.receiptId));
        add(LoadAllReceipts());
      },
    );
  }

  Future<void> _onRefreshReceipts(
    RefreshReceipts event,
    Emitter<ReceiptListState> emit,
  ) async {
    add(LoadAllReceipts());
  }

  Map<MonthYear, List<Receipt>> _groupReceiptsByMonth(List<Receipt> receipts) {
    final Map<MonthYear, List<Receipt>> grouped = {};

    for (final receipt in receipts) {
      if (!grouped.containsKey(receipt.monthYear)) {
        grouped[receipt.monthYear] = [];
      }
      grouped[receipt.monthYear]!.add(receipt);
    }

    return grouped;
  }
}
