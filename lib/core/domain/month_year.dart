import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MonthYear extends Equatable implements Comparable<MonthYear> {
  final int year;
  final int month;

  const MonthYear({
    required this.year,
    required this.month,
  }) : assert(month >= 1 && month <= 12, 'Month must be between 1 and 12');

  /// Creates a MonthYear from the current date
  factory MonthYear.now() {
    final now = DateTime.now();
    return MonthYear(year: now.year, month: now.month);
  }

  /// Creates a MonthYear from a DateTime
  factory MonthYear.fromDateTime(DateTime dateTime) {
    return MonthYear(year: dateTime.year, month: dateTime.month);
  }

  /// Parses a string in "yyyy-MM" format (e.g., "2024-01")
  factory MonthYear.parse(String value) {
    try {
      // Parse as "yyyy-MM" format
      final parts = value.split('-');
      if (parts.length != 2) {
        throw FormatException('Invalid format: expected yyyy-MM');
      }

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);

      return MonthYear(year: year, month: month);
    } catch (e) {
      throw FormatException('Failed to parse MonthYear from "$value": $e');
    }
  }

  /// Converts to DateTime (set to the 1st day of the month)
  DateTime toDateTime() {
    return DateTime(year, month);
  }

  /// Formats as "yyyy-MM" (e.g., "2024-01") for database storage
  String toIsoString() {
    return '$year-${month.toString().padLeft(2, '0')}';
  }

  /// Formats as "MMMM yyyy" (e.g., "January 2024") for display
  String toDisplayString() {
    return DateFormat('MMMM yyyy').format(toDateTime());
  }

  @override
  List<Object?> get props => [year, month];

  @override
  int compareTo(MonthYear other) {
    final yearComparison = year.compareTo(other.year);
    if (yearComparison != 0) return yearComparison;
    return month.compareTo(other.month);
  }

  @override
  String toString() => toIsoString();
}
