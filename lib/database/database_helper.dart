// db helper

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final String tableName = 'watchlist_movies';

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final path = await getDatabasesPath();
    final _databasePath = join(path, 'watchlist_database.db');

    return await openDatabase(_databasePath, version: 1,
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        voteAverage INTEGER,
        poster_path TEXT,
        backdrop_path TEXT,
        release_date TEXT
      )
    ''');
    });
  }

  static Future<void> insertAllPopularMovies(
      List<Map<String, dynamic>> products) async {
    final db = await database;
    // Gunakan transaction untuk menyisipkan semua produk secara bersamaan - kata gpt
    await db.transaction((txn) async {
      for (var product in products) {
        await txn.insert(tableName, product,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<void> removeMovies(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getAllPopularMovies() async {
    final db = await database;
    return db.query(tableName);
  }

   Future<void> insertWatchlist(List<int> watchlist) async {
  final db = await database;
  await db.transaction((txn) async {
    for (var id in watchlist) {
      await txn.insert(tableName, {'id': id},
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  });
}

 Future<List<int>> getAllWatchlist() async {
  final db = await database;
  final List<Map<String, dynamic>> watchlist = await db.query(tableName);
  return watchlist.map((map) => map['id'] as int).toList();
}


}
