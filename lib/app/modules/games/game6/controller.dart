import 'dart:math';

import 'package:first_app/app/core/utils/DataHelper.dart';
import 'package:first_app/app/data/models/content.dart';
import 'package:first_app/app/data/models/game_user.dart';
import 'package:first_app/app/data/models/user.dart';
import 'package:first_app/app/data/models/word.dart';

import 'package:get/get.dart';

class Game6Controller extends GetxController {
  late List<Content> avaliableContents;
  late Rx<Content> selectedContent;

  // all words coming from the chosen categories
  late List<Word> words;

  final currentGameIndex = 0.obs;

  late String gameMode;

  // randomWords chosen words for the game from words list
  Rx<List<Word>> randomWords = Rx<List<Word>>([]);

  final totalScore = 0.0.obs;
  final totalCoinCount = 0.obs;

  // it depends on the words count
  final baseScore = 0.0.obs;

  // to decrease the score after wrong choises
  final guestCount = 0.obs;

  final questionCount = 2;

  // check wheter if the game is ended
  final gameOver = false.obs;

  late DateTime startTime;

  // wheather if the pronunciation is open
  final isPronunciationOpen = false.obs;
  final chosenWordIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // get arguments
    words = Get.arguments[0] as List<Word>;
    gameMode = Get.arguments[1] as String;
    avaliableContents = Get.arguments[2] as List<Content>;

    startGame();
  }

  void startGame() {
    choseContent();
    startTime = DateTime.now();
    gameOver.value = false;
    guestCount.value = 0;
    totalScore.value = 0;
    totalCoinCount.value = 0;
    currentGameIndex.value = 0;

    words.shuffle();

    // choise first game questions
    randomWords.value = _getRandomWords();

    // fill base score according to game mode
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

  void choseContent() {
    Random random = Random();
    int index = random.nextInt(avaliableContents.length);
    var content = avaliableContents.elementAt(index);
    selectedContent = Rx(content);
  }

  Future correctAnswer() async {
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
    totalScore.value += baseScore.value / pow(2, guestCount.value);
    // game over
    if (currentGameIndex.value + 1 >= questionCount) {
      gameOver.value = true;
      await insertGameInfo();
    }
  }

  Future insertGameInfo() async {
    final elapsed = DateTime.now().difference(startTime);
    await DataHelper.instance.insert(
      "GameUser",
      GameUser(
        1,
        3,
        totalScore.value,
        elapsed.inSeconds,
        DateTime.now().toUtc(),
        gameOver.value,
      ),
    );

    // get user and update her/his coins
    var userMap = await DataHelper.instance.getAll("User");
    List<User> users = List.generate(userMap.length, (i) {
      return User.fromJson(userMap[i]);
    });
    var user = users.elementAt(0);

    await DataHelper.instance.update(
      "User",
      User(
        user.userID,
        user.name,
        user.surname,
        user.age,
        user.coin + totalCoinCount.value,
      ),
    );
  }

  void wrongAnswer() {
    guestCount.value++;
  }

  void getNextGame() async {
    guestCount.value = 0;

    if (currentGameIndex.value + 1 >= questionCount) {
      gameOver.value = true;
      await insertGameInfo();
    } else {
      currentGameIndex.value++;
      randomWords.value = _getRandomWords();
    }
  }

  List<Word> _getRandomWords() {
    switch (gameMode) {
      case "kolay":
        return _getRandomWordsWithCount(9);
      case "normal":
        return _getRandomWordsWithCount(4);
      case "zor":
        return _getRandomWordsWithCount(2);
      case "extreme":
        return _getRandomWordsWithCount(1);
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
    result.shuffle();
    return result;
  }

  int getCrossAxisCount() {
    if (isPronunciationOpen.value) {
      return 1;
    }
    if (gameMode == "kolay") {
      return 3;
    } else if (gameMode == "normal") {
      return 2;
    } else if (gameMode == "zor") {
      return 2;
    } else if (gameMode == "extreme") {
      return 1;
    }
    return 2;
  }
}
