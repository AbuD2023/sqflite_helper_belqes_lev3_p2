// lib/models/item.dart
import 'package:sqflite/sqflite.dart';
import '../helpers/database_helper.dart';

class Item {
  final int? id;
  final String name;
  final int value;

  Item({this.id, required this.name, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
    };
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, value: $value}';
  }

  static Future<int> insert(Item item) async {
    final db = await DatabaseHelper.create();
    return await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Item>> getAll() async {
    final db = await DatabaseHelper.create();
    final List<Map<String, dynamic>> maps = await db.query('items', orderBy: 'id');

    return List.generate(maps.length, (i) {
      return Item(
        id: maps[i]['id'],
        name: maps[i]['name'],
        value: maps[i]['value'],
      );
    });
  }

  static Future<Item?> getById(int id) async {
    final db = await DatabaseHelper.create();
    final List<Map<String, dynamic>> maps = await db.query(
      'items',
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Item(
        id: maps[0]['id'],
        name: maps[0]['name'],
        value: maps[0]['value'],
      );
    }
    return null;
  }

  static Future<void> update(Item item) async {
    final db = await DatabaseHelper.create();
    await db.update(
      'items',
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  static Future<void> deleteById(int id) async {
    final db = await DatabaseHelper.create();
    await db.delete('items', where: "id = ?", whereArgs: [id]);
  }
}