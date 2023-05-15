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
        backgroundColor: Colors.amber,
        appBar: AppBar(title: const Text(pageName)),
        body: Stack(children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                    image: AssetImage("assets/images/game3Back.jpg"),
                    fit: BoxFit.cover)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                height: 75,
                width: 150,
                color: Colors.red,
                child: const Text(
                  "Memory Game",
                  style: TextStyle(fontSize: 50),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              getGameTable()
            ],
          )
        ]));
  }

  Widget getGameTable() {
    return Container(
      width: 900,
      height: 515,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: const EdgeInsets.all(5),
      child: GridView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: controller.number_of_words,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, crossAxisSpacing: 20.0, mainAxisSpacing: 15.0),
          itemBuilder: (context, index) {
            Word currentWord = controller.gameWords[index];
            Map<String, String> allCouples = controller.couples;
            return Obx(() =>GestureDetector(
              onTap: () {
                controller.handleCardClick(currentWord);
              },
              child: getImageCard(currentWord),
            ));
          }),
    );
  }

  Container getImageCard(Word currentWord) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(controller.gameTable.value[currentWord.name] == true
                  ? currentWord.pictureSrc
                  : "assets/images/game/mark.png"),
              fit: BoxFit.cover),
          color: Colors.amber,
          border: Border.all(
            color: Colors.pink,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  void trackWord(Word word) async {
    bool control = await Future<bool>.delayed(
      const Duration(seconds: 2),
      () {
        return controller.gameTable.value[word.name]!;
      },
    );
    if (control &&
        !controller.gameTable.value[controller.couples[word.name]]!) {
      controller.gameTable.value[word.name] = false;
    }
  }
}
