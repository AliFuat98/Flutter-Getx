import 'package:get/get.dart';

class GamesController extends GetxController {
  final choosenCategoryTitle = "Family".obs;
  final chosenGameMode = "kolay".obs;
  final activeIndexOfDot = 0.obs;
  Rx<List<String>> selectedCategories = Rx<List<String>>([]);
  List<String> titles = [
    "Family",
    "Fruits",
    "Foods",
    "Vegetables",
    "Sports",
    "Occupations"
  ];
}
