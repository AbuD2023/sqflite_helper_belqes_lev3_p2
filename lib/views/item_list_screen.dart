// lib/views/item_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/item_provider.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).fetchItems();
  }

  Future<void> _addItem() async {
    final newItem = Item(name: 'Item ${nameController.text}', value: 1);
    await Provider.of<ItemProvider>(context, listen: false).addItem(newItem);
    nameController.clear();
  }

  Future<void> _updateItem(Item item) async {
    final updatedItem = Item(
        id: item.id, name: '${item.name} (Updated)', value: item.value + 1);
    await Provider.of<ItemProvider>(context, listen: false)
        .updateItem(updatedItem);
  }

  Future<void> _deleteItem(int id) async {
    await Provider.of<ItemProvider>(context, listen: false).deleteItem(id);
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite MVC Provider Example'),
      ),
      body: ListView.builder(
        itemCount: itemProvider.items.length,
        itemBuilder: (context, index) {
          final item = itemProvider.items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('Value: ${item.value}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _updateItem(item),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteItem(item.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Name of item'),
            actions: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'name of item'),
              ),
              ElevatedButton(
                onPressed: _addItem,
                child: Text('save'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
