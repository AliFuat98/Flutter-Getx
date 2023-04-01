import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:first_app/app/modules/games/game1/view.dart';
import 'package:first_app/app/modules/games/game2/view.dart';
import 'package:first_app/app/modules/games/game3/view.dart';
import 'package:first_app/app/modules/games/game4/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'controller.dart';

class GamesPage extends GetView<GamesController> {
  GamesPage({super.key});

  static const pageName = "/games";
  final categoryController = Get.find<CategoryController>();
  final caroController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final categoryTitleList = categoryController.getCategoryTitles();
    controller.choosenCategoryTitle.value = categoryTitleList.first;
    return Scaffold(
      appBar: AppBar(title: const Text("geri gelme")),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: ListView(
          children: [
            chooseCategoryTitle(),
            categoryDropdown(categoryTitleList),
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

  Widget categoryDropdown(List<String> categoryTitleList) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0.wp),
        child: DropdownButton<String>(
          dropdownColor: Colors.amber[200],
          value: controller.choosenCategoryTitle.value,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          alignment: Alignment.center,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            controller.choosenCategoryTitle.value =
                value ?? categoryTitleList.first;
          },
          items:
              categoryTitleList.map<DropdownMenuItem<String>>((String value) {
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
    return GestureDetector(
      onDoubleTap: () => goToGame(controller.activeIndexOfDot.value),
      child: CarouselSlider.builder(
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
        itemCount: 4,
        itemBuilder: (context, index, realIndex) {
          return Container(
            color: Colors.blueAccent[700],
            margin: EdgeInsets.symmetric(horizontal: 6.0.wp),
            child: Image.asset(
              'assets/images/game/game${index + 1}.jpg',
              height: 40.0.hp,
              width: 40.0.hp,
              fit: BoxFit.cover,
            ),
          );
        },
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
    switch (value) {
      case 0:
        Get.toNamed(Game1Page.pageName);
        break;
      case 1:
        Get.toNamed(Game2Page.pageName);
        break;
      case 2:
        Get.toNamed(Game3Page.pageName);
        break;
      case 3:
        Get.toNamed(Game4Page.pageName);
        break;
      default:
    }
  }
}
