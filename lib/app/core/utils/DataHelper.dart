import 'package:first_app/app/core/values/queries.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../data/models/Word.dart';

class DataHelper{
  static Database? _database;

  static Future<void> init() async{
    if(_database != null){
      return;
    }
    String dbPath = await getDatabasesPath();
    String myDbPath =  join(dbPath,"database.db");
    print(myDbPath);
    _database = await openDatabase(myDbPath,singleInstance: true,version: 1,onCreate: onCreate);
  }

  static void onCreate(Database db,int version) async {
      db.execute(wordTable);
      db.execute(categoryTable);
      wordTableRows.forEach((element) {
        db.execute(element);
      });
      categoryTableRows.forEach((element) {
        db.execute(element);
      });
  }

  static Future<int> insert(String table,Object object) async{
    if(object.runtimeType.toString() == "Word")
    {
      Word newWord = object as Word;
      return await _database!.insert(table, newWord.toJson());

    }
    Category newCategory = object as Category;
    return await _database!.insert(table, newCategory.toJson());
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
      final List<Map<String, dynamic>> maps = await _database!.query(table);
      return maps;
  }
  static Future<void> insertAll(String table,List<Map<String,dynamic>> maps) async{
    try{
      maps.forEach((element)
      async {
        await _database!.insert(table,element);
      });
    }catch(e,s){
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