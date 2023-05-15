import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/Word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Game3Page extends GetView<Game3Controller> {
  Game3Page({super.key});

  static const pageName = "/game3";
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
            onPressed: () {
              controller.getNextGame();
            },
            child: const Icon(
              Icons.navigate_next,
              size: 50,
              color: const Color.fromARGB(255, 10, 74, 185),
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
        if (word.wordID == controller.getCorrectWord().wordID) {
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
              color: const Color.fromARGB(255, 10, 74, 185),
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
              color: const Color.fromARGB(255, 10, 74, 185),
            ),
          ),
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
              color: const Color.fromARGB(255, 10, 74, 185),
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
              crossAxisCount: (controller.gameMode == "zor" ||
                      controller.gameMode == "extreme")
                  ? 3
                  : 2,
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
          image: AssetImage("assets/images/game3Back.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getGameTitle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.0.wp),
        child: Text(
          "DİNLE VE SEÇ",
          style: TextStyle(
            fontSize: 24.0.sp,
            fontWeight: FontWeight.bold,
          ),
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
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
                onPressed: () {},
                child: const Icon(
                  Icons.question_mark,
                  size: 25,
                  color: const Color.fromARGB(255, 10, 74, 185),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
                onPressed: () {
                  audioPlayer
                      .play(AssetSource(controller.getCorrectWord().audioSrc));
                },
                child: const Icon(
                  Icons.play_arrow,
                  size: 25,
                  color: const Color.fromARGB(255, 10, 74, 185),
                ),
              ),
            ],
          ),
          Obx(
            () => Row(
              children: [
                Icon(Icons.scoreboard),
                SizedBox(width: 1.0),
                Text(
                  "score: ${controller.totalScore.value}",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 2.0),
                Icon(Icons.monetization_on),
                SizedBox(width: 1.0),
                Text(
                  "coins: ${controller.totalCoinCount.value}",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 2.0),
                Icon(Icons.sports_volleyball),
                SizedBox(width: 1.0),
                Text(
                  controller.gameMode,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
