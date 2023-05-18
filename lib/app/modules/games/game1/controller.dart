import 'package:first_app/app/core/utils/DataHelper.dart';
import 'package:first_app/app/data/models/game_user.dart';
import 'package:first_app/app/data/models/user.dart';
import 'package:first_app/app/data/models/word.dart';
import 'package:get/get.dart';

class ExtendWordGame1 {
  Word word;
  bool isOpened;
  bool isCompleted;
  int coupleIndex;
  int index;
  ExtendWordGame1(
    this.word,
    this.isOpened,
    this.isCompleted,
    this.coupleIndex,
    this.index,
  );
}

class Game1Controller extends GetxController {
  // All words that come from selected categories
  late List<Word> selectedWords;

  // Word to be inserted to the game after shuffling
  late List<Word> gameWords;

  // Difficulty of the game
  late String gameMode;

  late Map<String, String> couples;
  RxMap<int, ExtendWordGame1> gameTable = RxMap<int, ExtendWordGame1>({});

  final totalScore = 0.0.obs;
  final totalCoinCount = 0.obs;

  final baseScore = 0.0.obs;

  late DateTime startTime;

  late int numberOfWords;

  // check wheter if the game is ended
  // if current couple count is numberofword then game is over
  final gameOver = false.obs;
  int currentCoupleCount = 0;

  final guessCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedWords = Get.arguments[0] as List<Word>;
    gameMode = Get.arguments[1] as String;

    startGame();
  }

  void startGame() {
    startTime = DateTime.now();
    gameOver.value = false;
    totalScore.value = 0;
    totalCoinCount.value = 0;
    currentCoupleCount = 0;

    baseScore.value = selectedWords.length.toDouble();
    if (gameMode == "kolay") {
      numberOfWords = 10;
      baseScore.value *= 2;
    } else if (gameMode == "normal") {
      numberOfWords = 20;
      baseScore.value *= 5;
    } else if (gameMode == "zor") {
      numberOfWords = 30;
      baseScore.value *= 10;
    } else if (gameMode == "extreme") {
      numberOfWords = 44;
      baseScore.value *= 15;
    }
    _generateGameWords();
  }

  void _generateGameWords() {
    List<Word> temporaryList = [];
    couples = {};
    gameWords = [];
    selectedWords.shuffle();
    for (int i = 0; i < numberOfWords / 2; i++) {
      temporaryList.add(selectedWords[i]);
    }
    for (var element in temporaryList) {
      gameWords.add(element);
      gameWords.add(Word.withoutID(
        "${element.name}twin",
        element.pictureSrc,
        element.audioSrc,
        element.isPronounced,
        element.pronunciationScore,
        element.reward,
        element.moduleID,
        element.isNew,
        element.isDeleted,
      ));
      couples[element.name] = "${element.name}twin";
      couples["${element.name}twin"] = element.name;
    }
    gameWords.shuffle();
    int index = 0;
    for (var element in gameWords) {
      gameTable[index] = ExtendWordGame1(
          element, false, false, _findCoupleIndex(element.name), index);
      index++;
    }
    gameTable.refresh();
  }

  int _findCoupleIndex(String name) {
    int index = 0;
    for (var element in gameWords) {
      if (element.name == "${name}twin") {
        break;
      }
      if (name.length > 4 &&
          element.name == name.substring(0, name.length - 4)) {
        break;
      }
      index++;
    }
    ;
    return index;
  }

  void handleCardClick(int index) {
    final openWords = _findOpenedWord();

    // spamı önle
    if (openWords.length >= 2) {
      return;
    }

    // first click
    if (openWords.isEmpty) {
      gameTable[index]!.isOpened = true;
      gameTable.refresh();
      return;
    }
    if (openWords.length == 1) {
      gameTable[index]!.isOpened = true;
      final secondword = gameTable[index]!;

      // farklı çıkarsa
      if (secondword.index != openWords.first.coupleIndex) {
        guessCount.value++;
        Future.delayed(const Duration(seconds: 1), () {
          _closeAll();
          gameTable.refresh();
        });
      }
      // aynı çıkarsa
      else {
        gameTable[index]!.isCompleted = true;
        gameTable[openWords.first.index]!.isCompleted = true;
        _correctAnswer();
      }
      gameTable.refresh();
      return;
    }
  }

  void _correctAnswer() async {
    // get score and some coin
    totalScore.value += baseScore.value * (10 / (guessCount.value + 1));
    totalCoinCount.value += 5;
    guessCount.value = 0;

    currentCoupleCount++;
    if (currentCoupleCount >= numberOfWords / 2) {
      gameOver.value = true;
      await insertGameInfo();
    }
    gameTable.refresh();
  }

  Future insertGameInfo() async {
    final elapsed = DateTime.now().difference(startTime);
    await DataHelper.instance.insert(
      "GameUser",
      GameUser(
        1,
        1,
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

  void _closeAll() {
    gameTable.forEach((key, value) {
      if (value.isOpened && !value.isCompleted) {
        value.isOpened = false;
      }
    });
  }

  List<ExtendWordGame1> _findOpenedWord() {
    List<ExtendWordGame1> result = [];
    for (int i = 0; i < numberOfWords; i++) {
      if (gameTable[i]!.isOpened && !gameTable[i]!.isCompleted) {
        result.add(gameTable[i]!);
      }
    }
    return result;
  }
}
