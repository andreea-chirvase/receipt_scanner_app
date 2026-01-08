import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/injection.dart';
import '../bloc/receipt_capture_bloc.dart';
import '../bloc/receipt_capture_event.dart';
import '../bloc/receipt_capture_state.dart';

class ReceiptCapturePage extends StatelessWidget {
  const ReceiptCapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReceiptCaptureBloc>(),
      child: const _ReceiptCaptureView(),
    );
  }
}

class _ReceiptCaptureView extends StatelessWidget {
  const _ReceiptCaptureView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Receipt'),
      ),
      body: BlocConsumer<ReceiptCaptureBloc, ReceiptCaptureState>(
        listener: (context, state) {
          if (state is ReceiptCaptureSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Receipt saved successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true); // Return true to indicate success
          } else if (state is ReceiptCaptureError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: theme.colorScheme.error,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    // User can retry by tapping camera button again
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ReceiptCaptureLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 24),
                  Text(
                    state.message,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 120,
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Scan Your Receipt',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Choose how you want to add your receipt',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<ReceiptCaptureBloc>().add(CapturePhotoEvent());
                      },
                      icon: const Icon(Icons.camera_alt, size: 28),
                      label: const Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        textStyle: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<ReceiptCaptureBloc>().add(PickFromGalleryEvent());
                      },
                      icon: const Icon(Icons.photo_library, size: 28),
                      label: const Text('Choose from Gallery'),
                      style: OutlinedButton.styleFrom(
                        textStyle: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'For best results, ensure the receipt is well-lit and clearly visible',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
