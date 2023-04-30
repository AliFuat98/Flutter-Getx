import 'package:first_app/app/data/services/storage/repository.dart';
import 'package:flutter/foundation.dart' as found;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first_app/app/data/models/category.dart';

import '../../data/models/Word.dart';

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
  void onInit() async {
    super.onInit();
    List<Category> data = await categoryRepository.readCategories();
    categories.assignAll(data);
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

  bool updateCategory(Category category, String wordName,String pictureSrc,String audioSrc,int reward) {
    var words = category.words!;
    if (words.any((element) => element.name == wordName)) {
      return false;
    }
    Word newWord = Word.withoutID(wordName,pictureSrc,audioSrc,0,-1,reward,category.ID);
    words.add(newWord);
    int oldIdx = categories.indexOf(category);
    categories[oldIdx].words = words;
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
    List<Word> newWords = [];
    newWords.addAll([
      ...doingWords,
      ...doneWords,
    ]);

    selectedCategory.value!.words = newWords;
    int oldIdx = categories.indexOf(selectedCategory.value);
    categories[oldIdx] = selectedCategory.value!;
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
    List<String> result = [];
    for (Category category in categories) {
      result.add(category.name);
    }
    return result;
  }
}
