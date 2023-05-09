import 'dart:math';

import 'package:first_app/app/data/models/Word.dart';
import 'package:get/get.dart';

class Game3Controller extends GetxController {
  late List<Word> words;
  late String gameMode;
  late Rx<Word> correctWord;
  final totalScore = 0.0.obs;
  final totalCoinCount = 0.obs;
  final baseScore = 0.0.obs;
  final guestCount = 0.obs;
  final changeQuestion = 0.obs;
  Rx<List<Word>> randomWords = Rx<List<Word>>([]);

  @override
  void onInit() {
    super.onInit();
    words = Get.arguments[0] as List<Word>;
    gameMode = Get.arguments[1] as String;
    randomWords.value = _getRandomWords();
    getRandomCorrectWord();
    baseScore.value = words.length.toDouble();
    if (gameMode == "kolay") {
      baseScore.value *= 2;
    } else if (gameMode == "normal") {
      baseScore.value *= 5;
    } else if (gameMode == "zor") {
      baseScore.value *= 10;
    } else if (gameMode == "extreme") {
      baseScore.value *= 15;
    }
  }

  void correctAnswer() {
    // get coin if s/he knows the answer in the first try
    if (guestCount.value == 0) {
      if (gameMode == "kolay") {
        totalCoinCount.value += 2;
      } else if (gameMode == "normal") {
        totalCoinCount.value += 5;
      } else if (gameMode == "zor") {
        totalCoinCount.value += 10;
      } else if (gameMode == "extreme") {
        totalCoinCount.value += 15;
      }
    }
    // get score
    totalScore.value +=
        baseScore.value / pow(2, (guestCount.value + changeQuestion.value));
    changeQuestion.value = 0;
  }

  void wrongAnswer() {
    guestCount.value++;
    changeQuestion.value = 0;
  }

  void getRandomCorrectWord() {
    Random random = Random();
    int index = random.nextInt(randomWords.value.length);
    correctWord = Rx(randomWords.value.elementAt(index));

    guestCount.value = 0;
  }

  void changeRandomwords() {
    randomWords.value = _getRandomWords();
    getRandomCorrectWord();
    changeQuestion.value++;
  }

  List<Word> _getRandomWords() {
    switch (gameMode) {
      case "kolay":
        return _getRandomWordsWithCount(2);
      case "normal":
        return _getRandomWordsWithCount(4);
      case "zor":
        return _getRandomWordsWithCount(6);
      case "extreme":
        return _getRandomWordsWithCount(9);
      default:
    }
    return List.empty();
  }

  List<Word> _getRandomWordsWithCount(int count) {
    List<Word> result = <Word>[];
    Random random = Random();

    for (int i = 0; i < count; i++) {
      int index = random.nextInt(words.length);
      var word = words.elementAt(index);

      // aynısı eklendiyse tekrar gir for'a
      if (result.contains(word)) {
        i--;
      } else {
        result.add(word);
      }
    }
    return result;
  }
}
