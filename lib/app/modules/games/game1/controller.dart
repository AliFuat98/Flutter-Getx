import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/word.dart';

class Game1Controller extends GetxController {
  // All words that come from selected categories
  late List<Word> selectedWords;
  // Word to be inserted to the game after shuffling
  late List<Word> gameWords;
  // Difficulty of the game
  late String gameMode;
  late int number_of_words;
  late Map<String, String> couples;
  Rx<Map<String, bool>> gameTable = Rx<Map<String, bool>>({});
  final gameOver = false.obs;
  final totalScore = 0.0.obs;
  final totalCoinCount = 0.obs;
  final baseScore = 0.0.obs;
  final guestCount = 0.obs;
  final changeQuestion = 0.obs;
  final dummy = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedWords = Get.arguments[0] as List<Word>;
    gameMode = Get.arguments[1] as String;
    if (gameMode == "kolay") {
      number_of_words = 12;
      baseScore.value *= 2;
    } else if (gameMode == "normal") {
      number_of_words = 16;
      baseScore.value *= 5;
    } else if (gameMode == "zor") {
      number_of_words = 20;
      baseScore.value *= 10;
    } else if (gameMode == "extreme") {
      number_of_words = 24;
      baseScore.value *= 15;
    }
    generateGameWords();
  }

  void generateGameWords() {
    List<Word> temporaryList = [];
    couples = {};
    gameWords = [];
    selectedWords.shuffle();
    for (int i = 0; i < number_of_words/2; i++) {
      temporaryList.add(selectedWords[i]);
    }
    temporaryList.forEach((element) {
      gameWords.add(element);
      gameWords.add(Word.withoutID(
          element.name + "twin",
          element.pictureSrc,
          element.audioSrc,
          element.isPronounced,
          element.pronunciationScore,
          element.reward,
          element.moduleID));
      couples[element.name] = element.name + "twin";
    });
    gameWords.shuffle();

    gameWords.forEach((element) {
      String name = element.name;
      gameTable.value[name] = false;
    });
  }

  void checkGameOver() {
    gameOver.value = !gameTable.value.containsValue(false);
  }

  void handleCardClick(Word currentWord) {
    Word clickedWord = currentWord;
    String name = clickedWord.name;
    String coupleName = couples[name]!;
    if (gameTable.value[name] == false) {
      gameTable.value[name] = true;
      gameTable.refresh();
      trackWord(name, coupleName);
    }

  }

  Future<void> trackWord(String name,String coupleName) async {
    bool control = await Future<bool>.delayed(
      const Duration(seconds: 3),
          () {
        return gameTable.value[coupleName]!;
      },
    );
    if (!control ) {
      gameTable.value[name] = false;
      gameTable.refresh();
    }
  }
}
