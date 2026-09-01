import 'package:restaurant_app/data/models/restaurant_favorites_list.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteService {
  static const String _database = 'favorite_list.db';
  static const String _table = 'favorites';
  static const int _version = 1;

  Future<void> createTable(Database database) async {
    await database.execute("""
      CREATE TABLE $_table(
        id TEXT PRIMARY KEY NOT NULL,
        name TEXT,
        image TEXT,
        city TEXT,
        rating REAL
      )
    """);
  }

  Future<Database> _initializeDB() async {
    return openDatabase(
      _database,
      version: _version,
      onCreate: (db, version) async => await createTable(db),
    );
  }

  Future<String> insertItem(RestaurantFavoritesList favorite) async {
    final db = await _initializeDB();
    final payload = favorite.toJson();
    final id = await db.insert(
      _table,
      payload,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id.toString();
  }

  Future<List<RestaurantFavoritesList>> getAllItems() async {
    final db = await _initializeDB();
    final results = await db.query(_table);

    return results.map((e) => RestaurantFavoritesList.fromJson(e)).toList();
  }

  Future<String> removeItem(String id) async {
    final db = await _initializeDB();
    final result = await db.delete(_table, where: 'id = ?', whereArgs: [id]);

    return result.toString();
  }

  Future<bool> isFavorited(String id) async {
    final db = await _initializeDB();
    final result = await db.query(_table, where: 'id = ?', whereArgs: [id]);

    return result.isNotEmpty;
  }
}
