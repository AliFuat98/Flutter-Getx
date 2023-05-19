import 'package:first_app/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

import 'controller.dart';

class ListenWordPage extends GetView<ListenwordController> {
  ListenWordPage({super.key});

  static const pageName = "/listenWord";
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('Listen Words'),
      ),
      body: Column(
        children: [
          SizedBox(height: 5.0.hp),
          getWordImage(),
          SizedBox(height: 5.0.hp),
          getWordName(),
          SizedBox(height: 5.0.hp),
          getPrevPlayNext(),
          SizedBox(height: 5.0.hp),
          getRecordButton(),
          SizedBox(height: 10.0.hp),
          getScoreBoard(),
        ],
      ),
    );
  }

  Widget getWordImage() {
    var wordS = controller.selectedCategory.words;
    return Obx(
      () => Container(
        height: 50.0.wp,
        width: 50.0.wp,
        decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.purple),
            color: Colors.lightGreenAccent),
        child: Image.asset(
          wordS.elementAt(controller.currentWordIndex.value).pictureSrc,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget getWordName() {
    var wordS = controller.selectedCategory.words;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            wordS.elementAt(controller.currentWordIndex.value).name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0.sp,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              shadows: const [
                Shadow(
                  color: Colors.purple,
                  offset: Offset(1, 2),
                  blurRadius: 4,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getPrevPlayNext() {
    var wordS = controller.selectedCategory.words;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            controller.decreaseCurrentWordIndex();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple, // Background color
          ),
          child: Text('Prev', style: TextStyle(fontSize: 30.0.sp)),
        ),
        ElevatedButton(
          onPressed: () {
            var audioPath =
                wordS.elementAt(controller.currentWordIndex.value).audioSrc;
            audioPlayer.play(AssetSource(audioPath));
          },
          child: const Icon(Icons.play_arrow),
        ),
        ElevatedButton(
          onPressed: () {
            controller.increaseCurrentWordIndex();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple, // Background color
          ),
          child: Text('Next', style: TextStyle(fontSize: 30.0.sp)),
        ),
      ],
    );
  }

  Widget getRecordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton.large(
          onPressed: () {
            controller.handleButtonPress();
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.mic),
        ),
      ],
    );
  }

  Widget getScoreBoard() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0.wp, 0.0.wp, 20.0.wp, 0.0.wp),
      width: 100.0.wp,
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 24.0,
          ),
          SizedBox(width: 8.0),
          Obx(() => Text(
                'Score: ${controller.pronunciationScore.value}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
