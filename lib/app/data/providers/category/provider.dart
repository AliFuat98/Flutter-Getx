import 'dart:convert';

import 'package:first_app/app/core/utils/keys.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:first_app/app/data/services/storage/services.dart';
import 'package:get/get.dart';

class CategoryProvider {
  final _storage = Get.find<StorageService>();

  List<Category> readCategories() {
    var categories = <Category>[];
    jsonDecode(_storage.read(categoryKey).toString())
        .forEach((e) => categories.add(Category.fromJson(e)));

    return categories;
  }

  void writeCategories(List<Category> categories) {
    _storage.write(categoryKey, jsonEncode(categories));
  }
}
