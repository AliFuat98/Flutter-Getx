import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Game4Page extends GetView<Game4Controller> {
  Game4Page({super.key});

  static const pageName = "/game4";
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
              getMenuButton(),
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

  Widget getMenuButton() {
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
              if (controller.gameOver.value) {
                await getEndGameDialog();
              } else {
                await getMenuDialog();
              }
            },
            child: const Icon(
              Icons.menu_outlined,
              size: 50,
              color: Color.fromARGB(255, 10, 74, 185),
            ),
          ),
        ],
      ),
    );
  }

  Future getMenuDialog() async {
    await Get.defaultDialog(
      barrierDismissible: true,
      titlePadding: EdgeInsets.symmetric(vertical: 3.0.wp),
      radius: 5,
      title: "PAUSED",
      content: Row(
        children: [
          Image.asset(
            "assets/images/backgroundGame4.jpg",
            fit: BoxFit.contain,
            width: 25.0.wp,
          ),
          Column(
            children: const [
              Text("HELAL"),
            ],
          ),
          // GO TO MENU
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () async {
              await controller.insertGameInfo();
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
            onPressed: () async {
              Get.back();
              await controller.insertGameInfo();
              controller.startGame();
            },
            child: const Icon(
              Icons.restart_alt,
              size: 50,
              color: Color.fromARGB(255, 10, 74, 185),
            ),
          ),

          // CONTINUE
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Icon(
              Icons.pause_sharp,
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
          // GO TO MENU
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            onPressed: () async {
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
            onPressed: () async {
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
        padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
        child: Center(
          child: Obx(
            () => GridView.builder(
              itemCount: controller.wordMap.keys.length,
              //padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                ExtendedWord? extendedword = controller.wordMap[index];
                return getDraggableImage(extendedword);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getDraggableImage(ExtendedWord? extendedWord) {
    return LongPressDraggable(
      data: extendedWord,
      feedback: Opacity(
        opacity: 0.8,
        child: getSquareImage(extendedWord),
      ),
      child: getSquareImage(extendedWord),
    );
  }

  Widget getSquareImage(ExtendedWord? extendedWord) {
    var squareWidth = Get.width - 20.0.wp;
    return DragTarget<ExtendedWord>(
      onAccept: (data) async {
        if (extendedWord == null) {
          return;
        }
        controller.handleDrag(extendedWord, data);
        // Get dialogs
        if (controller.gameOver.value) {
          await getEndGameDialog();
        }
      },
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: () async {
            if (extendedWord != null &&
                (!extendedWord.isImage || extendedWord.isCompleted)) {
              audioPlayer.play(AssetSource(extendedWord.word.audioSrc));
            }
          },
          child: Container(
            width: squareWidth / 5,
            height: squareWidth / 5,
            margin: EdgeInsets.all(3.0.wp),
            decoration: BoxDecoration(
              border: (extendedWord != null &&
                      extendedWord.isImage &&
                      extendedWord.isCompleted)
                  ? Border.all(
                      color: Colors.green.shade600,
                      width: 5.0,
                    )
                  : null,
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
              fit: (extendedWord != null && !extendedWord.isImage)
                  ? BoxFit.fill
                  : null,
              image: (extendedWord != null && extendedWord.isImage)
                  ? AssetImage(extendedWord.word.pictureSrc)
                  : const AssetImage("assets/images/game/mark.png"),
            ),
          ),
        );
      },
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
        onPressed: () async {
          await controller.insertGameInfo();
          Get.back();
        },
      ),
    );
  }

  Widget getBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgroundGame4.jpg"),
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  Widget getGameTitle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.0.wp),
        child: Text(
          "CANDY CRUSH",
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
                      getIconAndTextInfo(Icons.medical_services_outlined,
                          "Move: ${controller.moveCount.value}"),
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
