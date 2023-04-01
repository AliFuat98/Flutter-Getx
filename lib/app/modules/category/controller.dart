import 'package:first_app/app/data/services/storage/repository.dart';
import 'package:flutter/foundation.dart' as found;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/app/data/models/category.dart';

class CategoryController extends GetxController {
  CategoryRepository categoryRepository;

  CategoryController({
    required this.categoryRepository,
  });

  final categories = <Category>[].obs;
  final fromKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final selectedCategory = Rx<Category?>(null);
  final doneWords = <dynamic>[].obs;
  final doingWords = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    categories.assignAll(categoryRepository.readCategories());
    ever(categories, (_) => categoryRepository.writeCategories(categories));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addCategory(Category category) {
    // burdaki obje karşılaştırması equatible paketi sayesinde oluyor
    // title icon color karşılaştırılıyor props'ta
    if (categories.contains(category)) {
      return false;
    }

    categories.add(category);
    return true;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void deleteCategory(Category category) {
    categories.remove(category);
  }

  void changeSelectedCategory(Category? category) {
    selectedCategory.value = category;
  }

  bool updateCategory(Category category, String wordTitle) {
    var words = category.words ?? [];
    if (words.any((element) => element["title"] == wordTitle)) {
      return false;
    }

    var newWord = {'title': wordTitle, 'done': false};
    words.add(newWord);
    var newCategory = category.copyWith(words: words);
    int oldIdx = categories.indexOf(category);
    categories[oldIdx] = newCategory;
    categories.refresh();

    return true;
  }

  void changeWords(List<dynamic> select) {
    doingWords.clear();
    doneWords.clear();
    for (var i = 0; i < select.length; i++) {
      var word = select[i];
      var status = word["done"];
      if (status == true) {
        doneWords.add(word);
      } else {
        doingWords.add(word);
      }
    }
  }

  bool addWord(String title) {
    var word = {"title": title, "done": false};
    if (doingWords
        .any((element) => found.mapEquals<String, dynamic>(word, element))) {
      return false;
    }
    var doneWord = {"title": title, "done": true};
    if (doneWords.any(
        (element) => found.mapEquals<String, dynamic>(doneWord, element))) {
      return false;
    }
    doingWords.add(word);
    return true;
  }

  void updateWords() {
    var newWords = <Map<String, dynamic>>[];
    newWords.addAll([
      ...doingWords,
      ...doneWords,
    ]);

    var newCategory = selectedCategory.value!.copyWith(words: newWords);
    int oldIdx = categories.indexOf(selectedCategory.value);
    categories[oldIdx] = newCategory;
    categories.refresh();
  }

  void doneWord(String title) {
    var doingWord = {"title": title, "done": false};
    int index = doingWords.indexWhere(
        (element) => found.mapEquals<String, dynamic>(doingWord, element));
    doingWords.removeAt(index);

    var doneWord = {"title": title, "done": true};
    doneWords.add(doneWord);

    doingWords.refresh();
    doneWords.refresh();
  }

  void deleteDoneWord(dynamic doneWord) {
    int index = doneWords.indexWhere(
        (element) => found.mapEquals<String, dynamic>(doneWord, element));

    doneWords.removeAt(index);
    doneWords.refresh();
  }

  List<String> getCategoryTitles() {
    var result = <String>[];
    for (var element in categories) {
      result.add(element.title);
    }
    return result;
  }
}
