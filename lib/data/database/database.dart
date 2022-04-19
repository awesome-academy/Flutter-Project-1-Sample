import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vn_crypto/data/model/coin_local.dart';
import 'package:vn_crypto/data/model/invest.dart';

const String DB_NAME = "vncrypto_db";
const String FOLLOWING_TABLE = "following";
const String INVEST_TABLE = "invest";

class DatabaseProvider {
  static final DatabaseProvider databaseProvider = DatabaseProvider.init();
  Database? _database;

  DatabaseProvider.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      version: 1,
      onCreate: (db, version) {
        db.execute("""CREATE TABLE $FOLLOWING_TABLE (
            id String PRIMARY KEY,
            image TEXT
        )""");
        db.execute("""CREATE TABLE $INVEST_TABLE (
            id String PRIMARY KEY,
            name TEXT,
            symbol TEXT,
            image TEXT,
            current_price REAL,
            amount REAL
      )""");
      },
    );
  }

  Future<List<CoinLocal>> getCoins() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(FOLLOWING_TABLE);
    return List.generate(maps.length, (index) {
      return CoinLocal(maps[index]['id'], maps[index]['image']);
    });
  }

  Future<List<Invest>> getAllInvests() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(INVEST_TABLE);
    return List.generate(maps.length, (index) {
      return Invest(maps[index]["id"], maps[index]["name"], maps[index]["symbol"],
          maps[index]["image"], maps[index]["current_price"], maps[index]["amount"]);
    });
  }

  Future<int> insertCoin(CoinLocal coin) async {
    final db = await database;
    return await db.insert(FOLLOWING_TABLE, coin.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> insertInvest(Invest invest) async {
    final db = await database;
    return await db.insert(INVEST_TABLE, invest.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> deleteCoin(String coinId) async {
    final db = await database;
    return await db.delete(FOLLOWING_TABLE, where: "id = ?", whereArgs: [coinId]);
  }

  Future<int> deleteInvest(Invest itemCoin) async {
    final db = await database;
    return await db.delete(INVEST_TABLE, where: "id = ?", whereArgs: [itemCoin.id]);
  }

  Future<void> updateInvest(Invest invest) async {
    final db = await database;
    db.update(INVEST_TABLE, invest.toJson(), where: "id = ?", whereArgs: [invest.id]);
  }

  Future close() {
    return _database!.close();
  }

  Future deleteDB() async {
    return deleteDatabase(join(await getDatabasesPath(), DB_NAME));
  }
}
