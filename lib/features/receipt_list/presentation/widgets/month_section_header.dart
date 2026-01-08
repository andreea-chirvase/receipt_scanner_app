import 'package:flutter/material.dart';
import '../../../../core/domain/month_year.dart';

class MonthSectionHeader extends StatelessWidget {
  final MonthYear monthYear;
  final int receiptCount;
  final VoidCallback? onShareTap;

  const MonthSectionHeader({
    super.key,
    required this.monthYear,
    required this.receiptCount,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedMonth = monthYear.toDisplayString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedMonth,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$receiptCount receipt${receiptCount != 1 ? 's' : ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          if (onShareTap != null)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: onShareTap,
              tooltip: 'Share receipts from this month',
            ),
        ],
      ),
    );
  }
}
