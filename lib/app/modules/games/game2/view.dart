import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Game2Page extends GetView<Game2Controller> {
  Game2Page({super.key});

  static const pageName = "/game2";
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          getBackgroundImage(),
          Column(
            children: [
              getGameTitle(),
              SizedBox(
                height: 5.0.hp,
              ),
              getPlayScoreCoin(),
              SizedBox(
                height: 5.0.hp,
              ),
              getWordVoiceButtons(),
              getImages(),
              getNextButton(),
              SizedBox(
                height: 5.0.hp,
              )
            ],
          ),
          backButton(),
        ]),
      ),
    );
  }

  Widget getNextButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () async {
              controller.getNextGame();
              // Get dialogs
              if (controller.gameOver.value) {
                await getEndGameDialog();
              }
            },
            child: const Icon(
              Icons.navigate_next,
              size: 50,
              color: Color.fromARGB(255, 10, 74, 185),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSquareImage(Word word) {
    var squareWidth = Get.width - 20.0.wp;
    return GestureDetector(
      onTap: () async {
        if (word.wordID == controller.getMissingWord().wordID) {
          await controller.correctAnswer();

          // Get dialogs
          if (controller.gameOver.value) {
            await getEndGameDialog();
          } else {
            await getCorrectAnswerDialog();
            controller.getNextGame();
          }
        } else {
          EasyLoading.showError("yanlış");
          controller.wrongAnswer();
        }
      },
      child: Container(
        width: squareWidth / 5,
        height: squareWidth / 5,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            )
          ],
        ),
        child: Image(
          image: AssetImage(word.pictureSrc),
        ),
      ),
    );
  }

  Future getCorrectAnswerDialog() async {
    await Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: EdgeInsets.symmetric(vertical: 3.0.wp),
      radius: 5,
      title: "CORRECT ANSWER",
      content: Row(
        children: [
          Image.asset(
            "assets/images/game3Back.jpg",
            fit: BoxFit.contain,
            width: 25.0.wp,
          ),
          Column(
            children: const [
              Text("HELAL"),
              Text("OLSUN"),
              Text("LEN SANA"),
              Text("VELED"),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Icon(
              Icons.navigate_next,
              size: 50,
              color: Color.fromARGB(255, 10, 74, 185),
            ),
          ),
        ],
      ),
    );
  }

  Future getEndGameDialog() async {
    await Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: EdgeInsets.symmetric(vertical: 3.0.wp),
      radius: 5,
      title: "GAME IS OVER",
      content: Row(
        children: [
          Image.asset(
            "assets/images/game3Back.jpg",
            fit: BoxFit.contain,
            width: 25.0.wp,
          ),
          Column(
            children: const [
              Text("HELAL"),
              Text("OLSUN"),
              Text("LEN SANA"),
              Text("VELED"),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Icon(
              Icons.menu,
              size: 50,
              color: Color.fromARGB(255, 10, 74, 185),
            ),
          ),

          // RESTART GAME
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
              controller.startGame();
            },
            child: const Icon(
              Icons.restart_alt,
              size: 50,
              color: Color.fromARGB(255, 10, 74, 185),
            ),
          ),
        ],
      ),
    );
  }

  Widget getImages() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5.0.hp),
        child: Center(
          child: Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.randomWords.value
                    .map((word) => getSquareImage(word))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget backButton() {
    return Positioned(
      left: 4.0.wp,
      top: 4.0.wp,
      child: IconButton(
        icon: const Icon(
          Icons.backspace,
          size: 50,
          color: Colors.red,
        ),
        onPressed: () {
          controller.insertGameInfo();
          Get.back();
        },
      ),
    );
  }

  Widget getBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgroundGame2.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget getGameTitle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.0.wp),
        child: Text(
          "OLMAYANI BUL",
          style: TextStyle(
            fontSize: 24.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getWordVoiceButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...controller.randomWordsWithotMissing.value.map((word) {
              return getSingleVoiceButton(word.audioSrc);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget getSingleVoiceButton(String audioSrc) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 10, 74, 185),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          elevation: 0,
        ),
        onPressed: () {
          audioPlayer.play(AssetSource(audioSrc));
        },
        child: const Icon(
          Icons.play_arrow_outlined,
          size: 25,
          color: Color.fromARGB(255, 10, 74, 185),
        ),
      ),
    );
  }

  Widget getPlayScoreCoin() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Question mark
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 10, 74, 185),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
              onPressed: () {},
              child: const Icon(
                Icons.question_mark,
                size: 25,
                color: Color.fromARGB(255, 10, 74, 185),
              ),
            ),
          ),
          // score table
          Obx(
            () => SizedBox(
              width: 70.0.wp,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIconAndTextInfo(Icons.monetization_on,
                          "coins: ${controller.totalCoinCount.value}"),
                      getIconAndTextInfo(
                          Icons.sports_volleyball, controller.gameMode),
                    ],
                  ),
                  SizedBox(
                    height: 3.0.wp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getIconAndTextInfo(
                          Icons.medical_services_outlined, "Move: ${0}"),
                      getIconAndTextInfo(Icons.scoreboard,
                          "score: ${controller.totalScore.value}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getIconAndTextInfo(IconData data, String text) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(data, size: 5.0.wp),
          Text(
            text,
            style: TextStyle(
              fontSize: 10.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
