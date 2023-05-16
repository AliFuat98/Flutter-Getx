import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/models/word.dart';
class ExtendWord{
  Word word;
  bool isOpened;
  bool isCompleted;
  bool isWaiting;
  int coupleIndex;
  int index;
  ExtendWord(this.word,this.isOpened,this.isCompleted,this.isWaiting,this.coupleIndex,this.index,);
}
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
  Rx<Map<String, bool>> isCompleted = Rx<Map<String, bool>>({});
  RxMap<int, ExtendWord> gameTablev2 = RxMap<int, ExtendWord>({});
  final gameOver = false.obs;
  final totalScore = 0.0.obs;
  final totalCoinCount = 0.obs;
  final baseScore = 0.0.obs;
  final guestCount = 0.obs;
  final changeQuestion = 0.obs;
  final dummy = false.obs;
  Rx<List<String>> waiting = Rx<List<String>>([]);
  Rx<List<String>> opened = Rx<List<String>>([]);
  bool syncControl = true;
  bool waitingControl = false;
  bool writingControl = true;
  bool readingControl = true;

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
    //generateGameWordsv2();
  }
 void generateGameWordsv2(){
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
     couples[element.name+"twin"] = element.name;
   });
   gameWords.shuffle();
   int index = 0;
   gameWords.forEach((element) {
     gameTablev2[index] = ExtendWord(element,false, false,false, findCoupleIndex(element.name), index);
     index++;
   });
   print("gel");
 }
 int findCoupleIndex(String name){
    int index = 0;
    for(var element in gameWords)
    {

     if(element.name == name+"twin"){
       break;
     }
     index++;
   };
   return index;
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
      couples[element.name+"twin"] = element.name;
    });
    gameWords.shuffle();

    gameWords.forEach((element) {
      String name = element.name;
      gameTable.value[name] = false;
      isCompleted.value[name] = false;
    });
  }

  void checkGameOver() {
    gameOver.value = !gameTable.value.containsValue(false);
  }

  // Map<String, String> couples;
  //  Rx<Map<String, bool>> gameTable = Rx<Map<String, bool>>({});
  /*  Rx<List<String>> waiting = Rx<List<String>>([]);
  Rx<List<String>> opened = Rx<List<String>>([]);*/
  void handleCardClickV2(ExtendWord currentWord){
    int openCount = findOpenCount();
    if( openCount >= 2){
      return;
    }
    if(openCount == 0){
      currentWord.isOpened = true;



    }
  }
  int findOpenCount(){
    int count = 0;
    for(int i=0;i<number_of_words;i++){
      if(gameTablev2[i]!.isOpened){
        count++;
      }
    }
    return count;
  }

  Future handleCardClick(Word currentWord) async {
    Word clickedWord = currentWord;
    String name = clickedWord.name;
    String coupleName = couples[name]!;
    waitingControl = false;

    if (gameTable.value[name] == false) {
      while(!readingControl);
      readingControl = false;
      if(opened.value.length < 2){
        if(waiting.value.length == 0){
          gameTable.value[name] = true;
          gameTable.refresh();
          opened.value.add(name);
          opened.refresh();
          waiting.value.add(name);
          waiting.refresh();
          readingControl = true;
          trackWord(name, coupleName);
        }
        else if(waiting.value.length == 1)
        {
          waitingControl = true;
          gameTable.value[name] = true;
          opened.value.add(name);
          opened.refresh();
          readingControl = true;
          gameTable.refresh();
          if(waiting.value[0] != couples[name]){
            Future.delayed(Duration(seconds: 1), () {
              gameTable.value[waiting.value[0]] = false;
              gameTable.value[name] = false;
              gameTable.refresh();
              opened.value.clear();
              waiting.value.clear();
            });
          }
          else{
            opened.value.clear();
            waiting.value.clear();
          }
        }
      }
      else{
        readingControl = true;
      }
    }
  }
  void closeOthers(){
    gameTable.value.entries.forEach((element) {
      if(gameTable.value[couples[element.key]] == false){
          gameTable.value[element.key] = false;
        }
    });



  }
  Future<void> trackWord(String name,String coupleName) async {
    bool control = await Future<bool>.delayed(
      const Duration(seconds: 3),
          () {
        return gameTable.value[coupleName]!;
      },
    );
    if (!control && !waitingControl) {
      gameTable.value[name] = false;
      gameTable.refresh();
      waiting.value.clear();
      opened.value.clear();
    }
  }
}
