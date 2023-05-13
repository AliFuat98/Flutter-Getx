import 'package:first_app/app/core/utils/dataHelper.dart';
import 'package:first_app/app/data/services/storage/repository.dart';
import 'package:get/get.dart';

import '../../data/models/game.dart';

class GamesController extends GetxController {
  GeneralRepository gameRepository;

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
    super.onInit();
    await DataHelper.init();
    List<Game> data = await gameRepository.readGames();
    games.assignAll(data);
    //ever(categories, (_) => categoryRepository.writeCategories(categories));
  }
}
