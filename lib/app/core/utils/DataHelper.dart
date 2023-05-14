import 'package:first_app/app/core/values/queries.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

import '../../data/models/Word.dart';

class DataHelper {
  static final DataHelper instance = DataHelper._init();
  static Database? _database;

  DataHelper._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // sqflite_ffi.sqfliteFfiInit();
    // databaseFactory = sqflite_ffi.databaseFactoryFfi;
    String dbPath = await getDatabasesPath();
    String myDbPath = join(dbPath, "database.db");
    print(myDbPath);
    return await openDatabase(myDbPath,
        singleInstance: true, version: 1, onCreate: _onCreate);
  }

  static void _onCreate(Database db, int version) async {
    print("on create first time");
    db.execute(wordTable);
    db.execute(categoryTable);
    db.execute(gameTable);
    wordTableRows.forEach((element) {
      db.execute(element);
    });
    categoryTableRows.forEach((element) {
      db.execute(element);
    });
    gameTableRows.forEach((element) {
      db.execute(element);
    });
  }

  Future<int> insert(String table, Object object) async {
    final db = await instance.database;

    if (object.runtimeType.toString() == "Word") {
      Word newWord = object as Word;
      return await db.insert(table, newWord.toJson());
    }
    Category newCategory = object as Category;
    return await db.insert(table, newCategory.toJson());
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    print(maps.length);
    return maps;
  }

  Future<void> insertAll(String table, List<Map<String, dynamic>> maps) async {
    try {
      final db = await instance.database;
      maps.forEach((element) async {
        await db.insert(table, element);
      });
    } catch (e, s) {
      print(e);
    }
  }
}

/*
if(table == "Word")
      {
        final List<Map<String, dynamic>> maps = await _database!.query('Word');
        List<Word> words = List.generate(maps.length, (i) {
          return Word.fromJson(maps[i]);
        });
        return words;
      }
      else if(table == "Category")
      {
        final List<Map<String, dynamic>> maps = await _database!.query('Category');
        List<Category> words = List.generate(maps.length, (i) {
          return Cate.fromJson(maps[i]);
        });
        return words;

      }

*/