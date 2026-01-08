import 'package:equatable/equatable.dart';
import '../../../../core/domain/month_year.dart';

abstract class ReceiptListEvent extends Equatable {
  const ReceiptListEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllReceipts extends ReceiptListEvent {}

class LoadReceiptsByMonth extends ReceiptListEvent {
  final MonthYear monthYear;

  const LoadReceiptsByMonth(this.monthYear);

  @override
  List<Object?> get props => [monthYear];
}

class SearchReceiptsEvent extends ReceiptListEvent {
  final String query;

  const SearchReceiptsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class DeleteReceiptEvent extends ReceiptListEvent {
  final String receiptId;

  const DeleteReceiptEvent(this.receiptId);

  @override
  List<Object?> get props => [receiptId];
}

class RefreshReceipts extends ReceiptListEvent {}
