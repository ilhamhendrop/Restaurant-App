import 'package:restaurant_app/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  static const String _tblRestaurant = 'restaurants';

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_app.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblRestaurant (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating DOUBLE
        )''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblRestaurant, restaurant.toJson());
  }

  Future<void> removeRestaurant(String id) async {
    final db = await database;

    await db!.delete(
      _tblRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Restaurant>> getAllRestaurant() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblRestaurant);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getRestaurantById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblRestaurant,
      where: 'id = ?',
      whereArgs: [id],
    );

    if(results.isNotEmpty){
      return results.first;
    }

    return {};
  }

}