import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/month_year.dart';
import '../../../../di/injection.dart';
import '../../../receipt_sharing/domain/usecase/generate_monthly_pdf_use_case.dart';
import '../../../receipt_sharing/domain/usecase/share_receipts_use_case.dart';
import '../../../receipt_storage/domain/model/receipt.dart';
import '../bloc/receipt_list_bloc.dart';
import '../bloc/receipt_list_event.dart';
import '../bloc/receipt_list_state.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/month_section_header.dart';
import '../widgets/receipt_card.dart';
import '../widgets/search_bar_widget.dart';

class ReceiptListPage extends StatelessWidget {
  const ReceiptListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReceiptListBloc>()..add(LoadAllReceipts()),
      child: const _ReceiptListView(),
    );
  }
}

class _ReceiptListView extends StatefulWidget {
  const _ReceiptListView();

  @override
  State<_ReceiptListView> createState() => _ReceiptListViewState();
}

class _ReceiptListViewState extends State<_ReceiptListView> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipts'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  context.read<ReceiptListBloc>().add(LoadAllReceipts());
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching)
            SearchBarWidget(
              onSearch: (query) {
                context.read<ReceiptListBloc>().add(SearchReceiptsEvent(query));
              },
              onClear: () {
                context.read<ReceiptListBloc>().add(LoadAllReceipts());
              },
            ),
          Expanded(
            child: BlocBuilder<ReceiptListBloc, ReceiptListState>(
              builder: (context, state) {
                if (state is ReceiptListLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ReceiptListError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            state.message,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ReceiptListBloc>().add(LoadAllReceipts());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is ReceiptListLoaded) {
                  if (state.receipts.isEmpty) {
                    return EmptyStateWidget(
                      title: 'No Receipts Yet',
                      message: 'Tap the + button to scan your first receipt',
                      icon: Icons.receipt_long,
                      actionLabel: 'Scan Receipt',
                      onActionTap: () {
                        // Navigate to camera
                        Navigator.pushNamed(context, '/capture');
                      },
                    );
                  }

                  // Sort months in descending order
                  final sortedMonths = state.groupedByMonth.keys.toList()
                    ..sort((a, b) => b.compareTo(a));

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<ReceiptListBloc>().add(RefreshReceipts());
                      await Future.delayed(const Duration(milliseconds: 500));
                    },
                    child: ListView.builder(
                      itemCount: sortedMonths.fold<int>(
                        0,
                        (sum, month) =>
                            sum + 1 + state.groupedByMonth[month]!.length,
                      ),
                      itemBuilder: (context, index) {
                        int currentIndex = 0;
                        for (final month in sortedMonths) {
                          if (index == currentIndex) {
                            // Month header
                            return MonthSectionHeader(
                              monthYear: month,
                              receiptCount: state.groupedByMonth[month]!.length,
                              onShareTap: () {
                                _shareMonthReceipts(
                                  context,
                                  month,
                                  state.groupedByMonth[month]!,
                                );
                              },
                            );
                          }
                          currentIndex++;

                          final receiptsInMonth = state.groupedByMonth[month]!;
                          final receiptIndexInMonth = index - currentIndex;

                          if (receiptIndexInMonth < receiptsInMonth.length) {
                            final receipt = receiptsInMonth[receiptIndexInMonth];
                            return ReceiptCard(
                              receipt: receipt,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/receipt-detail',
                                  arguments: receipt,
                                );
                              },
                              onLongPress: () {
                                _showDeleteDialog(context, receipt.id);
                              },
                            );
                          }

                          currentIndex += receiptsInMonth.length;
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  );
                }

                return const EmptyStateWidget(
                  title: 'No Receipts',
                  message: 'Start by scanning your first receipt',
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/capture');
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String receiptId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Receipt'),
        content: const Text('Are you sure you want to delete this receipt? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<ReceiptListBloc>().add(DeleteReceiptEvent(receiptId));
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Receipt deleted')),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareMonthReceipts(
    BuildContext context,
    MonthYear monthYear,
    List<Receipt> receipts,
  ) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Generating PDF...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      // Generate PDF
      final generatePdfUseCase = getIt<GenerateMonthlyPdfUseCase>();
      final result = await generatePdfUseCase(
        GenerateMonthlyPdfParams(
          monthYear: monthYear,
          receipts: receipts,
        ),
      );

      // Close loading dialog
      if (context.mounted) Navigator.pop(context);

      await result.fold(
        (failure) async {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${failure.message}'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        (sharePackage) async {
          // Share the PDF
          final shareUseCase = getIt<ShareReceiptsUseCase>();
          final shareResult = await shareUseCase(
            ShareReceiptsParams(sharePackage),
          );

          shareResult.fold(
            (failure) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error sharing: ${failure.message}'),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
            (_) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'PDF generated with ${sharePackage.receiptCount} receipts',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          );
        },
      );
    } catch (e) {
      // Close loading dialog if still open
      if (context.mounted) Navigator.pop(context);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unexpected error: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
