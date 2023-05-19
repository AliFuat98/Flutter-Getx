import 'dart:ffi';

import 'package:first_app/app/data/models/category.dart';
import 'package:first_app/app/data/models/word.dart';
import 'package:first_app/app/data/services/category/category_repository.dart';
import 'package:first_app/app/data/services/game/game_repository.dart';
import 'package:get/get.dart';

import '../../data/models/game.dart';

class GamesController extends GetxController {
  GameRepository gameRepository;
  CategoryRepository categoryRepository;

  GamesController({
    required this.gameRepository,
    required this.categoryRepository,
  });

  final games = <Game>[].obs;

  final chosenGameMode = "kolay".obs;
  final activeIndexOfDot = 0.obs;
  List<Category> categories = [];
  Rx<List<int>> selectedCategoryIDs = Rx<List<int>>([]);

  @override
  void onInit() async {
    super.onInit();
    List<Game> data = await gameRepository.readGames();
    games.assignAll(data);

    categories = await categoryRepository.readCategories();
  }

  bool checkChosen(int categoryID) {
    return selectedCategoryIDs.value.contains(categoryID);
  }

  void toggleChosenCategory(int id) {
    if (checkChosen(id)) {
      selectedCategoryIDs.value.remove(id);
    } else {
      selectedCategoryIDs.value.add(id);
      selectedCategoryIDs.refresh();
    }
    selectedCategoryIDs.refresh();
  }

  List<Word> getWordsFromChosenCategories() {
    var categoryList = categories
        .map(
          (category) {
            if (selectedCategoryIDs.value.contains(category.ID)) {
              return category;
            }
          },
        )
        .where((e) => e != null)
        .toList();

    // get chosen words from chosen categories
    List<Word> words = <Word>[];
    for (var category in categoryList) {
      for (var word in category!.words) {
        words.add(word);
      }
    }
    return words;
  }
}
