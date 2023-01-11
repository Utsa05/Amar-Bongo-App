import 'package:amar_bongo_app/data/models/item_model.dart';
import 'package:amar_bongo_app/domain/entities/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  String dbName = 'MYDB.db';
  Future<Database> initDb() async {
    final filePath = await getDatabasesPath();
    final path = join(filePath, dbName);

    return openDatabase(path, onCreate: (database, version) async {
      String textTYPE = 'TEXT NOT NULL';
      String idTYPE = 'INTEGER PRIMARY KEY AUTOINCREMENT';

      await database.execute('''
        CREATE TABLE MYDB(
          id $idTYPE,
          title $textTYPE,
          image $textTYPE,
          category $textTYPE,
          url $textTYPE
        )
        
        ''');
    }, version: 1);
  }

  //insert
  Future<bool> insert(ItemFavModel dailyPad) async {
    Database db = await initDb();
    db.insert('MYDB', dailyPad.toMap());
    return true;
  }

  //fetch daily pad
  Future<List<ItemFavModel>> fetchList() async {
    Database db = await initDb();
    List<Map<String, Object?>> padList = await db.query('MYDB');

    return padList.map((e) => ItemFavModel.fromSnapshot(e)).toList();
  }

  //upda
  Future<int> update(ItemFavModel dailyPad) async {
    Database db = await initDb();

    return await db.update('MYDB', dailyPad.toMap(),
        where: 'id = ?', whereArgs: [dailyPad.id]);
  }

  //delete
  Future<int> delete(int id) async {
    Database db = await initDb();
    return await db.delete(
      'MYDB',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //close
  Future close() async {
    Database db = await initDb();

    return db.close();
  }
}
