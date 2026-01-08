import 'package:equatable/equatable.dart';
import '../../../../core/domain/month_year.dart';
import '../../../receipt_storage/domain/model/receipt.dart';

abstract class ReceiptListState extends Equatable {
  const ReceiptListState();

  @override
  List<Object?> get props => [];
}

class ReceiptListInitial extends ReceiptListState {}

class ReceiptListLoading extends ReceiptListState {}

class ReceiptListLoaded extends ReceiptListState {
  final List<Receipt> receipts;
  final Map<MonthYear, List<Receipt>> groupedByMonth;

  const ReceiptListLoaded({
    required this.receipts,
    required this.groupedByMonth,
  });

  @override
  List<Object?> get props => [receipts, groupedByMonth];
}

class ReceiptListError extends ReceiptListState {
  final String message;

  const ReceiptListError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReceiptDeleting extends ReceiptListState {
  final String receiptId;

  const ReceiptDeleting(this.receiptId);

  @override
  List<Object?> get props => [receiptId];
}

class ReceiptDeleted extends ReceiptListState {
  final String receiptId;

  const ReceiptDeleted(this.receiptId);

  @override
  List<Object?> get props => [receiptId];
}
