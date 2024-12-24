// lib/providers/item_provider.dart
import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  Future<void> fetchItems() async {
    _items = await Item.getAll();
    notifyListeners();
  }

  Future<void> addItem(Item item) async {
    await Item.insert(item);
    await fetchItems();
  }

  Future<void> updateItem(Item item) async {
    await Item.update(item);
    await fetchItems();
  }

  Future<void> deleteItem(int id) async {
    await Item.deleteById(id);
    await fetchItems();
  }
}
