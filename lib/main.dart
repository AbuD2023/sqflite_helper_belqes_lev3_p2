// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_helper/helpers/database_helper.dart';
import 'providers/item_provider.dart';
import 'views/item_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكد من تهيئة Flutter
  await DatabaseHelper.create(); // تأكد من إنشاء قاعدة البيانات
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: MaterialApp(
        title: 'SQLite MVC Provider Example',
        home: ItemListScreen(),
      ),
    );
  }
}
