import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/word.dart';
import 'package:first_app/app/modules/games/game1/view.dart';
import 'package:first_app/app/modules/games/game2/view.dart';
import 'package:first_app/app/modules/games/game3/view.dart';
import 'package:first_app/app/modules/games/game4/view.dart';
import 'package:first_app/app/modules/games/widgets/choose_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'controller.dart';
import 'game5/view.dart';

class GamesPage extends GetView<GamesController> {
  GamesPage({super.key});

  static const pageName = "/games";
  final caroController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("geri gelme")),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: [
            backButton(),
            chooseCategoryButton(),
            //chooseCategoryTitle(),
            //categoryDropdown(),
            gameModeDropdown(),
            //chooseGameTitle(),
            Expanded(
              child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gameImageSlider(),
                    SizedBox(height: 5.0.hp),
                    sliderDots(),
                    SizedBox(height: 5.0.hp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        previousNextButton(Icons.arrow_left, false),
                        playButton(),
                        previousNextButton(Icons.arrow_right, true),
                      ],
                    ),
                    SizedBox(height: 5.0.hp),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return Padding(
      padding: EdgeInsets.all(1.0.wp),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ],
      ),
    );
  }

  Widget chooseCategoryButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(20.0.sp),
            textStyle: TextStyle(fontSize: 14.0.sp)),
        onPressed: () {
          Get.to(
            () => ChooseCategory(),
            transition: Transition.downToUp,
          );
        },
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(1.0.wp),
              child: Icon(Icons.category, size: 7.0.wp),
            ),
            SizedBox(width: 5.0.wp),
            const Expanded(child: Text("choose category"))
          ],
        ),
      ),
    );
  }

  Widget chooseCategoryTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(2.0.wp),
      child: Text(
        "Choose a Category",
        style: TextStyle(fontSize: 4.0.hp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget gameModeDropdown() {
    var choseList = ["kolay", "normal", "zor", "extreme"];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0.wp),
      child: Obx(
        () => DropdownButton(
          value: controller.chosenGameMode.value,
          onChanged: (value) {
            controller.chosenGameMode.value = value ?? choseList.first;
          },
          items: choseList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget chooseGameTitle() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(4.0.hp),
      child: Text(
        "Choose a game",
        style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget gameImageSlider() {
    //var gameList = controller.games.elementAt(0);
    return GestureDetector(
      onDoubleTap: () => goToGame(controller.activeIndexOfDot.value),
      child: Obx(
        () => CarouselSlider(
          carouselController: caroController,
          options: CarouselOptions(
            height: 40.0.hp,
            initialPage: 0,
            //autoPlay: true,
            //autoPlayInterval: const Duration(seconds: 5),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            onPageChanged: (index, reason) {
              controller.activeIndexOfDot.value = index;
            },
          ),
          items: [
            ...controller.games.map((element) {
              return Container(
                color: Colors.blueAccent[700],
                margin: EdgeInsets.symmetric(horizontal: 6.0.wp),
                child: Image.asset(
                  element.pictureSrc,
                  height: 40.0.hp,
                  width: 40.0.hp,
                  fit: BoxFit.cover,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget sliderDots() {
    return Obx(
      () => AnimatedSmoothIndicator(
        activeIndex: controller.activeIndexOfDot.value,
        count: 5,
        onDotClicked: (index) => {
          controller.activeIndexOfDot.value = index,
          caroController.animateToPage(index),
        },
        effect: JumpingDotEffect(
          dotWidth: 4.0.wp,
          //dotColor:activeDotColor:
        ),
      ),
    );
  }

  Widget previousNextButton(IconData? data, bool next) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      onPressed: () {
        if (next) {
          caroController.nextPage();
          return;
        }
        caroController.previousPage();
      },
      child: Icon(
        data,
        size: 25,
        color: const Color.fromARGB(255, 10, 74, 185),
      ),
    );
  }

  Widget playButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      onPressed: () => goToGame(controller.activeIndexOfDot.value),
      child: const Text(
        "Oyna",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  void goToGame(int value) {
    try {
      if (controller.selectedCategoryIDs.value.isEmpty) {
        EasyLoading.showError("Choose a category");
        return;
      }

      List<Word> words = controller.getWordsFromChosenCategories();

      switch (value) {
        case 0:
          Get.toNamed(Game1Page.pageName,
              arguments: [words, controller.chosenGameMode.value]);
          break;
        case 1:
          Get.toNamed(Game2Page.pageName,
              arguments: [words, controller.chosenGameMode.value]);
          break;
        case 2:
          Get.toNamed(Game3Page.pageName,
              arguments: [words, controller.chosenGameMode.value]);
          break;
        case 3:
          Get.toNamed(Game4Page.pageName,
              arguments: [words, controller.chosenGameMode.value]);
          break;
        case 4:
          Get.toNamed(Game5Page.pageName,
              arguments: [words, controller.chosenGameMode.value]);
          break;
        default:
      }
    } catch (e) {
      EasyLoading.showError("something goes wrong");
      return;
    }
  }
}
