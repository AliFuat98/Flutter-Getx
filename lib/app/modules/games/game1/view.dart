import 'package:first_app/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/word.dart';
import 'controller.dart';

class Game1Page extends GetView<Game1Controller> {
  Game1Page({super.key});

  static const pageName = "/game1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getBackgroundImage(),
          Column(
            children: [
              getGameTitle(),
              SizedBox(
                height: 3.0.hp,
              ),
              getPlayScoreCoin(),
              getGameTable(),
              getMenuButton(),
              SizedBox(
                height: 3.0.hp,
              ),
            ],
          ),
          backButton(),
        ],
      ),
    );
  }

  Widget getGameTable() {
    return Expanded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0.wp),
          child: Obx(
            () => GridView.builder(
              shrinkWrap: true,
              itemCount: controller.gameTable.keys.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                Word currentWord = controller.gameWords[index];
                return GestureDetector(
                  onTap: () async {
                    controller.handleCardClick(index);
                    if (controller.gameOver.value) {
                      await getEndGameDialog();
                    }
                  },
                  child: getImageCard(currentWord, index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Container getImageCard(Word currentWord, int index) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            controller.gameTable[index]!.isOpened
                ? currentWord.pictureSrc
                : "assets/images/game/mark.png",
          ),
          fit: BoxFit.cover,
        ),
        color: Colors.amber,
        border: Border.all(
          color: Colors.pink,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget getMenuButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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

  Widget getBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/backgroundGame1.jpg"),
          fit: BoxFit.fitHeight,
          alignment: Alignment.centerRight,
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
        onPressed: () async {
          await controller.insertGameInfo();
          Get.back();
        },
      ),
    );
  }

  Widget getGameTitle() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.0.wp),
        child: Text(
          "FIND COUPLE",
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
                          "Move: ${controller.guessCount.value}"),
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
