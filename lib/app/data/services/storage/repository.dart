import 'package:first_app/app/data/models/game.dart';
import 'package:first_app/app/data/providers/category/provider.dart';
import 'package:first_app/app/data/providers/game/provider.dart';

import '../../models/Word.dart';
import '../../models/category.dart';
import '../../providers/word/provider.dart';

class GeneralRepository {
  CategoryProvider categoryProvider;
  WordProvider wordProvider;
  GameProvider gameProvider;

  GeneralRepository({
    required this.categoryProvider,
    required this.wordProvider,
    required this.gameProvider,
  });

  Future<List<Category>> readCategories() async {
    List<Category> categories = await categoryProvider.readCategories();
    List<Word> allWords = await wordProvider.readWords();
    categories.forEach((element) {
      List<Word> categoryWords = [];
      int categoryID = element.ID;
      allWords.forEach((element) {
        element.moduleID == categoryID ? categoryWords.add(element) : {};
      });
      element.words = categoryWords;
    });
    return categories;
  }

  void writeCategories(List<Category> categories) =>
      categoryProvider.writeCategories(categories);

  Future<List<Game>> readGames() async {
    List<Game> games = await gameProvider.readGames();
    return games;
  }
}
