import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../../core/constants/database_constants.dart';
import '../../../../core/error/exceptions.dart' as app_exceptions;
import '../model/receipt_model.dart';

abstract class ReceiptLocalDataSource {
  Future<void> initDatabase();
  Future<void> insertReceipt(ReceiptModel receipt);
  Future<void> updateReceipt(ReceiptModel receipt);
  Future<void> deleteReceipt(String id);
  Future<ReceiptModel?> getReceiptById(String id);
  Future<List<ReceiptModel>> getAllReceipts();
  Future<List<ReceiptModel>> searchReceipts(String query);
  Future<List<String>> getDistinctMonths();
  Future<int> getReceiptCount();
  Future<int> getReceiptCountByMonth(String monthYear);
  Future<double?> getTotalAmount();
  Future<List<ReceiptModel>> getRecentReceipts(int limit);
  Future<Map<String, int>> getMonthlyReceiptCounts(int monthsCount);
}

@LazySingleton(as: ReceiptLocalDataSource)
class ReceiptLocalDataSourceImpl implements ReceiptLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  @override
  Future<Database> initDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, DatabaseConstants.databaseName);

      return await openDatabase(
        path,
        version: DatabaseConstants.databaseVersion,
        onCreate: (db, version) async {
          await db.execute(DatabaseConstants.createReceiptsTable);
          await db.execute(DatabaseConstants.createMonthYearIndex);
          await db.execute(DatabaseConstants.createDateCapturedIndex);
          await db.execute(DatabaseConstants.createExtractedTextIndex);
        },
      );
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to initialize database: $e');
    }
  }

  @override
  Future<void> insertReceipt(ReceiptModel receipt) async {
    try {
      final db = await database;
      await db.insert(
        DatabaseConstants.receiptsTable,
        receipt.toDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to insert receipt: $e');
    }
  }

  @override
  Future<void> updateReceipt(ReceiptModel receipt) async {
    try {
      final db = await database;
      await db.update(
        DatabaseConstants.receiptsTable,
        receipt.toDatabase(),
        where: '${DatabaseConstants.columnId} = ?',
        whereArgs: [receipt.id],
      );
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to update receipt: $e');
    }
  }

  @override
  Future<void> deleteReceipt(String id) async {
    try {
      final db = await database;
      await db.delete(
        DatabaseConstants.receiptsTable,
        where: '${DatabaseConstants.columnId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to delete receipt: $e');
    }
  }

  @override
  Future<ReceiptModel?> getReceiptById(String id) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseConstants.receiptsTable,
        where: '${DatabaseConstants.columnId} = ?',
        whereArgs: [id],
      );

      if (results.isEmpty) return null;
      return ReceiptModelX.fromDatabase(results.first);
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get receipt by id: $e');
    }
  }

  @override
  Future<List<ReceiptModel>> getAllReceipts() async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseConstants.receiptsTable,
        orderBy: '${DatabaseConstants.columnDateCaptured} DESC',
      );

      return results.map((map) => ReceiptModelX.fromDatabase(map)).toList();
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get all receipts: $e');
    }
  }

  @override
  Future<List<ReceiptModel>> searchReceipts(String query) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseConstants.receiptsTable,
        where: '${DatabaseConstants.columnExtractedText} LIKE ? OR ${DatabaseConstants.columnMerchantName} LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: '${DatabaseConstants.columnDateCaptured} DESC',
      );

      return results.map((map) => ReceiptModelX.fromDatabase(map)).toList();
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to search receipts: $e');
    }
  }

  @override
  Future<List<String>> getDistinctMonths() async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseConstants.receiptsTable,
        columns: [DatabaseConstants.columnMonthYear],
        distinct: true,
        orderBy: '${DatabaseConstants.columnMonthYear} DESC',
      );

      return results
          .map((map) => map[DatabaseConstants.columnMonthYear] as String)
          .toList();
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get distinct months: $e');
    }
  }

  @override
  Future<int> getReceiptCount() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DatabaseConstants.receiptsTable}',
      );
      return result.first['count'] as int;
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get receipt count: $e');
    }
  }

  @override
  Future<int> getReceiptCountByMonth(String monthYear) async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DatabaseConstants.receiptsTable} WHERE ${DatabaseConstants.columnMonthYear} = ?',
        [monthYear],
      );
      return result.first['count'] as int;
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get receipt count by month: $e');
    }
  }

  @override
  Future<double?> getTotalAmount() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT SUM(${DatabaseConstants.columnTotalAmount}) as total FROM ${DatabaseConstants.receiptsTable} WHERE ${DatabaseConstants.columnTotalAmount} IS NOT NULL',
      );
      return result.first['total'] as double?;
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get total amount: $e');
    }
  }

  @override
  Future<List<ReceiptModel>> getRecentReceipts(int limit) async {
    try {
      final db = await database;
      final results = await db.query(
        DatabaseConstants.receiptsTable,
        orderBy: '${DatabaseConstants.columnDateCaptured} DESC',
        limit: limit,
      );

      return results.map((map) => ReceiptModelX.fromDatabase(map)).toList();
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get recent receipts: $e');
    }
  }

  @override
  Future<Map<String, int>> getMonthlyReceiptCounts(int monthsCount) async {
    try {
      final db = await database;
      final results = await db.rawQuery(
        '''
        SELECT ${DatabaseConstants.columnMonthYear}, COUNT(*) as count
        FROM ${DatabaseConstants.receiptsTable}
        GROUP BY ${DatabaseConstants.columnMonthYear}
        ORDER BY ${DatabaseConstants.columnMonthYear} DESC
        LIMIT ?
        ''',
        [monthsCount],
      );

      return Map.fromEntries(
        results.map((map) => MapEntry(
              map[DatabaseConstants.columnMonthYear] as String,
              map['count'] as int,
            )),
      );
    } catch (e) {
      throw app_exceptions.DatabaseException('Failed to get monthly receipt counts: $e');
    }
  }
}
