// lib/helpers/database_helper.dart
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        value INTEGER
      );
    ''');
  }

  static Future<sql.Database> create() async {
    return sql.openDatabase(
      'itme.db',
      version: 1,
      onCreate: (sql.Database db, version) {
        createTable(db);
      },
    );
  }

  // Future<int> insertItem(Item item) async {
  //   final db = await DatabaseHelper.create();
  //   final data = {
  //     'name': item.name,
  //     'value': item.value,
  //   };
  //   final id = await db.insert(
  //     'items',
  //     data,
  //     conflictAlgorithm: sql.ConflictAlgorithm.replace,
  //   );
  //   return id;
  // }

  // Future<List<Item>> getItems() async {
  //   final db = await DatabaseHelper.create();
  //   final List<Map<String, dynamic>> maps =
  //       await db.query('items', orderBy: 'id');

  //   return List.generate(maps.length, (i) {
  //     return Item(
  //       id: maps[i]['id'],
  //       name: maps[i]['name'],
  //       value: maps[i]['value'],
  //     );
  //   });
  // }

  // Future<Item?> getItemById(int id) async {
  //   final db = await DatabaseHelper.create();
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'items',
  //     where: "id = ?",
  //     whereArgs: [id],
  //   );

  //   if (maps.isNotEmpty) {
  //     return Item(
  //       id: maps[0]['id'],
  //       name: maps[0]['name'],
  //       value: maps[0]['value'],
  //     );
  //   }
  //   return null;
  // }

  // Future<void> updateItem(Item item) async {
  //   final db = await DatabaseHelper.create();
  //   await db.update(
  //     'items',
  //     item.toMap(),
  //     where: "id = ?",
  //     whereArgs: [item.id],
  //   );
  // }

  // Future<void> deleteItemById(int id) async {
  //   final db = await DatabaseHelper.create();
  //   try {
  //     await db.delete('items', where: "id = ?", whereArgs: [id]);
  //   } catch (e) {
  //     log('error: $e');
  //   }
  // }
}
