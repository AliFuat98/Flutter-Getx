import 'dart:convert';

import 'package:first_app/app/core/utils/DataHelper.dart';
import 'package:first_app/app/core/utils/keys.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:first_app/app/data/services/storage/services.dart';
import 'package:get/get.dart';

class CategoryProvider
{

  Future<List<Category>> readCategories() async {
    final List<Map<String, dynamic>> categoryMaps = await DataHelper.getAll("Category");
    final List<Map<String,dynamic>> wordMaps = await DataHelper.getAll("Word");
    List<Category> categories = List.generate(categoryMaps.length, (i) {
      return Category.fromJson(categoryMaps[i]);
    });
    return categories;
  }
  void writeCategories(List<Category> categories) {
    List<Map<String,dynamic>> maps = [];

    categories.forEach((element) {
      maps.add(element.toJson());
    });
    DataHelper.insertAll("Category", maps);
  }
}
