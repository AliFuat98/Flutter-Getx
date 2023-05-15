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
          onPressed: () {},
          backgroundColor: Colors.red,
          child: const Icon(Icons.mic),
        ),
      ],
    );
  }
}
