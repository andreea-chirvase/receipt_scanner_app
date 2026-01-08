import 'package:flutter/material.dart';
import '../../features/receipt_capture/presentation/pages/receipt_capture_page.dart';
import '../../features/receipt_list/presentation/pages/receipt_detail_page.dart';
import '../../features/receipt_list/presentation/pages/receipt_list_page.dart';
import '../../features/receipt_storage/domain/model/receipt.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.receiptList:
        return MaterialPageRoute(
          builder: (_) => const ReceiptListPage(),
        );

      case RouteNames.receiptCapture:
        return MaterialPageRoute(
          builder: (_) => const ReceiptCapturePage(),
        );

      case RouteNames.receiptDetail:
        final receipt = settings.arguments as Receipt;
        return MaterialPageRoute(
          builder: (_) => ReceiptDetailPage(receipt: receipt),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
