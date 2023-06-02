import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/app/data/models/word.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameWord {
  String name;
  String pictureSrc;
  String audioSrc;
  bool isCorrect;

  GameWord(this.name, this.pictureSrc, this.audioSrc, this.isCorrect);
}

class Game5Controller extends GetxController {
  // all words coming from the chosen categories
  late List<Word> words;
  late String gameMode;
  late Rx<List<GameWord>> gameWords = Rx<List<GameWord>>([]);
  final wordIndex = 0.obs;
  AudioPlayer general_audio_player = AudioPlayer();
  AudioPlayer choice_audio_player = AudioPlayer();
  AudioPlayer listen_audio_player = AudioPlayer();
  late Rx<MaterialAccentColor> wrongButton;
  final is_wrong_clickable = false.obs;
  late Rx<MaterialAccentColor> correctButton;
  final is_correct_clickable = false.obs;
  late IconButton playButton;
  late IconButton correctIcon;
  late IconButton wrongIcon;
  final totalCoinCount = 0.obs;
  final totalScore = 0.obs;
  Rx<IconButton> currentButton =
      IconButton(onPressed: () {}, icon: Icon(Icons.add)).obs;
  final gameOver = false.obs;

  @override
  void onInit() {
    super.onInit();
    words = Get.arguments[0] as List<Word>;
    gameMode = Get.arguments[1] as String;
    wrongButton = Colors.deepPurpleAccent.obs;
    correctButton = createColor(Colors.blue).obs;
    correctIcon = IconButton(
      splashRadius: 50.0,
      splashColor: Colors.green,
      color: Colors.lightGreen,
      iconSize: 50,
      icon: Icon(Icons.check),
      onPressed: () {},
    );
    wrongIcon = IconButton(
      splashRadius: 50.0,
      splashColor: Colors.green,
      color: Colors.red,
      iconSize: 50,
      icon: Icon(Icons.close),
      onPressed: () {},
    );
    playButton = IconButton(
      splashRadius: 50.0,
      splashColor: Colors.green,
      color: Colors.lightGreen,
      iconSize: 50,
      icon: Icon(Icons.play_circle),
      onPressed: () {
        listen_audio_player
            .play(AssetSource(gameWords.value[wordIndex.value].audioSrc));
      },
    );
    currentButton.value = playButton;
    generateWords();
  }

  void generateWords() {
    Random random = Random();
    int number_of_correct_words = random.nextInt(8) + 1;
    int number_of_incorrect_words = 10 - number_of_correct_words;
    words.shuffle();
    List<Word> sublist =
        words.getRange(0, 10 + number_of_incorrect_words).toList();
    int index = 10;
    for (int i = 0; i < 10; i++) {
      if (i < number_of_correct_words) {
        gameWords.value.add(GameWord(
            sublist[i].name, sublist[i].pictureSrc, sublist[i].audioSrc, true));
      } else {
        gameWords.value.add(GameWord(sublist[i].name, sublist[i].pictureSrc,
            sublist[index].audioSrc, false));
        index++;
      }
    }
    gameWords.value.shuffle();
    gameWords.value.forEach((element) {
      print("element:${element.name}  isCorrect:${element.isCorrect}");
    });
  }

  void playStartingSpeech() async {
    await Future.delayed(Duration(seconds: 2));
    general_audio_player.play(AssetSource("audios/Game5/firstSpeech.mp3"));
    int counter = 0;
    StreamSubscription<void>? audioPlayerCompletionListener;
    audioPlayerCompletionListener =
        general_audio_player.onPlayerComplete.listen((event) async {
      if (counter == 0) {
        await Future.delayed(Duration(seconds: 1));
        general_audio_player
            .play(AssetSource(gameWords.value[wordIndex.value].audioSrc));
        counter++;
      } else if (counter == 1) {
        audioPlayerCompletionListener!.cancel();
        is_wrong_clickable.value = true;
        is_correct_clickable.value = true;
        is_correct_clickable.refresh();
        is_wrong_clickable.refresh();
        wrongButton.refresh();
        correctButton.refresh();
      }
    });
  }

  Future<void> handleUserSelect(bool choice, Function callback) async {
    is_wrong_clickable.value = false;
    is_correct_clickable.value = false;
    is_correct_clickable.refresh();
    is_wrong_clickable.refresh();
    StreamSubscription<void>? audioPlayerCompletionListener;
    audioPlayerCompletionListener =
        choice_audio_player.onPlayerComplete.listen((event) async {
      await Future.delayed(Duration(seconds: 1));
      if (wordIndex.value == 9) {
        gameOver.value = true;
        gameOver.refresh();
        callback();
        return;
      }
      wordIndex.value++;
      wordIndex.refresh();
      currentButton.value = playButton;
      currentButton.refresh();
      correctButton.value = createColor(Colors.blue);
      correctButton.refresh();
      wrongButton.value = Colors.deepPurpleAccent;
      StreamSubscription<void>? audioPlayerCompletionListener2;
      audioPlayerCompletionListener2 =
          listen_audio_player.onPlayerComplete.listen((event) async {
        await Future.delayed(Duration(seconds: 1));
        is_wrong_clickable.value = true;
        is_correct_clickable.value = true;
        is_correct_clickable.refresh();
        is_wrong_clickable.refresh();
        audioPlayerCompletionListener2!.cancel();
      });
      audioPlayerCompletionListener!.cancel();
      await Future.delayed(Duration(seconds: 1));
      await listen_audio_player
          .play(AssetSource(gameWords.value[wordIndex.value].audioSrc));
    });

    if (gameWords.value[wordIndex.value].isCorrect == choice) {
      if (choice == true) {
        correctButton.value = createColor(Colors.lightGreen);
        correctButton.refresh();
      } else {
        wrongButton.value = createColor(Colors.lightGreen);
        wrongButton.refresh();
      }
      currentButton.value = correctIcon;
      currentButton.refresh();
      totalScore.value += 1000;
      totalScore.refresh();
      await choice_audio_player.play(AssetSource("audios/Game5/correct.mp3"));
    } else {
      if (choice == true) {
        correctButton.value = Colors.redAccent;
        correctButton.refresh();
      } else {
        wrongButton.value = Colors.redAccent;
        wrongButton.refresh();
      }
      currentButton.value = wrongIcon;
      currentButton.refresh();
      totalScore.value += 500;
      totalScore.refresh();
      await choice_audio_player.play(AssetSource("audios/Game5/wrong.mp3"));
    }
    totalCoinCount.value = totalScore.value ~/ 200;
    totalCoinCount.refresh();
  }

  MaterialAccentColor createColor(MaterialColor color) {
    return MaterialAccentColor(
      color.value,
      <int, Color>{
        100: color[100]!, // Replace with the desired swatch value
        400: color[400]!,
        200: color[200]!,
        700: color[700]!,
      },
    );
  }
}
