import 'package:first_app/app/data/services/game/game_repository.dart';
import 'package:get/get.dart';

import '../../data/models/game.dart';

class GamesController extends GetxController {
  GameRepository gameRepository;

  GamesController({
    required this.gameRepository,
  });

  final games = <Game>[].obs;

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

  @override
  void onInit() async {
    List<Game> data = await gameRepository.readGames();
    games.assignAll(data);
    super.onInit();
    //ever(categories, (_) => categoryRepository.writeCategories(categories));
  }
}
