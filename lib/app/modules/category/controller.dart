import 'package:first_app/app/data/services/storage/repository.dart';
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

  @override
  void onInit() async {
    super.onInit();
    List<Category> data = await categoryRepository.readCategories();
    categories.assignAll(data);
    //ever(categories, (_) => categoryRepository.writeCategories(categories));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  // yeni kategori ekleme
  bool addCategory(Category category) {
    if (categories.contains(category)) {
      return false;
    }
    categories.add(category);
    return true;
  }

  // kategori sil
  void deleteCategory(Category category) {
    categories.remove(category);
  }

  // sürükle bırak ile categori silerken kullanılır
  void changeDeleting(bool value) {
    deleting.value = value;
  }

  // kategori seçme işleminden sonra seçilenin tutulması
  void changeSelectedCategory(Category? category) {
    selectedCategory.value = category;
  }

  bool updateCategory(
    Category category,
    String wordName,
    String pictureSrc,
    String audioSrc,
    int reward,
  ) {
    var words = category.words;
    if (words.any((element) => element.name == wordName)) {
      return false;
    }
    Word newWord = Word.withoutID(
        wordName, pictureSrc, audioSrc, 0, -1, reward, category.ID);
    words.add(newWord);
    int oldIdx = categories.indexOf(category);
    categories[oldIdx].words = words;
    categories.refresh();
    return true;
  }

  // yeni kelime ekleme önceden seçilmiş olan kategoriye
  bool addWord(String title) {
    return true;
  }

  // kategorilerin başlıklarını çekmek için
  List<String> getCategoryTitles() {
    List<String> result = [];
    for (Category category in categories) {
      result.add(category.name);
    }
    return result;
  }
}
