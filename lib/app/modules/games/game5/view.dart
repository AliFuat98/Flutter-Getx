import 'package:audioplayers/audioplayers.dart';
import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Game5Page extends GetView<Game5Controller> {
  Game5Page(){
    controller.playStartingSpeech();
  }
  static const pageName = "/game5";
  AudioPlayer audioPlayer = AudioPlayer();

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
                    image: AssetImage("assets/images/game5back.jpeg"),
                    fit: BoxFit.cover)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              getPlayScoreCoin(),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,5,20,20),
                padding: EdgeInsets.all(5),
                width: 200,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Obx(()=>ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    controller.gameWords.value[controller.wordIndex.value].pictureSrc,
                    fit: BoxFit.fill,
                  ),
                )),
              ),
              SizedBox(
                height: 100,
              ),
              Obx(()=>Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: controller.correctButton.value,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: 120.0,
                      height: 60.0,
                      onPressed: controller.is_correct_clickable.value ? () {
                        controller.handleUserSelect(true,(){
                          if(controller.gameOver.value == true){
                            getEndGameDialog();
                          }
                        });
                        // Handle button 1 press
                      } : null,
                      child: Text(
                        'Correct',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: controller.wrongButton.value,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: MaterialButton(
                      minWidth: 120.0,
                      height: 60.0,
                      onPressed: controller.is_wrong_clickable.value ? () {
                         controller.handleUserSelect(false,(){
                           if(controller.gameOver.value == true){
                             getEndGameDialog();
                           }
                         });
                        // Handle button 1 press
                      } : null,
                      child: Text(
                        'Wrong',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
       Positioned(
            top: 480,
            left: 160,
            child: Obx(()=>Container(
              alignment: Alignment.center,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0,color: Colors.green),
                color: Colors.white,
                borderRadius: BorderRadius.circular(80)
              ),
              child: controller.currentButton.value,
            )),
          )
        ]));
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
                          "Move: ${1}"),
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