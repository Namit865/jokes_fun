import 'dart:async';
import 'package:jokes_fun/Model/quote.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'quotes_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE quotes(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, author TEXT, isFavorite INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertQuote(Quote quote) async {
    final Database db = await database;
    await db.insert(
      'quotes',
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Quote>> getFavoriteQuotes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('quotes', where: 'isFavorite = ?', whereArgs: [1]);
    return List.generate(maps.length, (i) {
      return Quote(
        id: maps[i]['id'],
        content: maps[i]['content'],
        author: maps[i]['author'],
        isFavorite: maps[i]['isFavorite'] == 1,
      );
    });
  }

  Future<void> updateQuoteFavoriteStatus(int id, bool isFavorite) async {
    final Database db = await database;
    await db.update(
      'quotes',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
