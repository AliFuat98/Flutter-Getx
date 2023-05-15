import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/Word.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:first_app/app/modules/games/game1/view.dart';
import 'package:first_app/app/modules/games/game2/view.dart';
import 'package:first_app/app/modules/games/game3/view.dart';
import 'package:first_app/app/modules/games/game4/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:multiselect/multiselect.dart';

import 'controller.dart';

class GamesPage extends GetView<GamesController> {
  GamesPage({super.key});

  static const pageName = "/games";
  final CategoryController categoryController = Get.find<CategoryController>();
  final caroController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("geri gelme")),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: ListView(
          children: [
            chooseCategoryTitle(),
            categoryDropdown(),
            gameModeDropdown(),
            chooseGameTitle(),
            Column(
              children: [
                gameImageSlider(),
                SizedBox(height: 5.0.hp),
                sliderDots(),
                SizedBox(height: 2.0.hp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    previousNextButton(Icons.arrow_left),
                    playButton(),
                    previousNextButton(Icons.arrow_right),
                  ],
                ),
                SizedBox(height: 5.0.hp),
              ],
            )
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

  Widget categoryDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0.wp),
      child: Obx(
        () => DropDownMultiSelect(
          options: categoryController.categories
              .map((element) => element.name)
              .toList(),
          whenEmpty: "Select Categories",
          onChanged: (value) {
            controller.selectedCategories.value = value;
          },
          selectedValues: controller.selectedCategories.value,
        ),
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
        count: 4,
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

  Widget previousNextButton(IconData? data) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      onPressed: () {
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
      if (controller.selectedCategories.value.isEmpty) {
        EasyLoading.showError("Choose a category");
        return;
      }

      // get chosen categories
      var categoryList = categoryController.categories
          .map(
            (category) {
              if (controller.selectedCategories.value.contains(category.name)) {
                return category;
              }
            },
          )
          .where((e) => e != null)
          .toList();

      // get chosen words from chosen categories
      List<Word> words = <Word>[];
      for (var category in categoryList) {
        for (var word in category!.words) {
          words.add(word);
        }
      }

      switch (value) {
        case 0:
          Get.toNamed(Game1Page.pageName,arguments: [words,controller.chosenGameMode.value]);
          break;
        case 1:
          Get.toNamed(Game2Page.pageName);
          break;
        case 2:
          Get.toNamed(Game3Page.pageName,
              arguments: [words, controller.chosenGameMode.value]);
          break;
        case 3:
          Get.toNamed(Game4Page.pageName);
          break;
        default:
      }
    } catch (e) {
      EasyLoading.showError("something goes wrong");
      return;
    }
  }
}
