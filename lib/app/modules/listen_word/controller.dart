import 'package:first_app/app/data/models/category.dart';
import 'package:get/get.dart';

class ListenwordController extends GetxController {
  late Category selectedCategory;
  final currentWordIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedCategory = Get.arguments as Category;
  }

  void decreaseCurrentWordIndex() {
    if (currentWordIndex.value <= 0) {
      return;
    }
    currentWordIndex.value--;
  }

  void increaseCurrentWordIndex() {
    if (currentWordIndex.value >= selectedCategory.words.length - 1) {
      return;
    }
    currentWordIndex.value++;
  }
}
