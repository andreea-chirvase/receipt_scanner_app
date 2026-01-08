import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/router/app_router.dart';
import 'app/router/route_names.dart';
import 'app/theme/app_theme.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize dependency injection
  configureDependencies();

  runApp(const ReceiptScannerApp());
}

class ReceiptScannerApp extends StatelessWidget {
  const ReceiptScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receipt Scanner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: RouteNames.receiptList,
      onGenerateRoute: AppRouter.generateRoute,
      builder: (context, child) {
        return SafeArea(
          top: false, 
          bottom: true, 
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
