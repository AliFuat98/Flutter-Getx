import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/core/values/colors.dart';
import 'package:first_app/app/modules/listen_word/view.dart';
import 'package:first_app/app/modules/category_map/controller.dart';
import 'package:first_app/app/widgets/file_operations.dart';
import 'package:first_app/app/widgets/positions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../category/controller.dart';

class CategoryMapPage extends GetView<CategoryMapController> {
  CategoryMapPage({super.key});

  static const pageName = "/categoryMap";
  final caroController = CarouselController();

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    var positionList = getPositions();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () {
          var index = -1;
          return Stack(children: [
            InteractiveViewer(
              maxScale: 3,
              constrained: false,
              transformationController: controller.transCtrl.value,
              child: Stack(children: [
                Image.asset(
                  "assets/images/map.png",
                  width: 1200,
                ),
                ...categoryController.categoryListForMap.map((category) {
                  index++;
                  // fazla category olduğunda hata vermemesi için ilerde silinebilir
                  return Positioned(
                    left: positionList[index].leftPosition,
                    top: positionList[index].topPosition,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(ListenWordPage.pageName,
                            arguments: category);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: getImage(
                                    category.isNew, category.pictureSrc),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.black, width: 1.5)),
                      ),
                    ),
                  );
                }).toList(),
              ]),
            ),
            backButton(),
            getCategoriesv2(),
          ]);
        },
      ),
      //floatingActionButton: resetScaleButton(),
    );
  }

  Widget getCategoriesv2() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 3.0.hp),
      child: CarouselSlider(
        carouselController: caroController,
        options: CarouselOptions(
          height: 3.0.hp,
          initialPage: categoryController.mapIndex.value,
          //autoPlay: true,
          //autoPlayInterval: const Duration(seconds: 5),
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          onPageChanged: (index, reason) {
            categoryController.mapIndex.value = index;
            categoryController.changeMap();
          },
        ),
        items: [
          ...categoryController.mapList.map((element) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(193, 1, 155, 104),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: brightBlue200,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: AssetImage(element.pictureSrc),
                // ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10.0.wp),
              child: Center(
                child: Text(
                  element,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            );
          }).toList(),
        ],
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
          Get.back();
        },
      ),
    );
  }

  Widget resetScaleButton() {
    return FloatingActionButton(
      heroTag: const Uuid().v4(),
      onPressed: () {
        final animationReset = Matrix4Tween(
          begin: controller.transCtrl.value.value,
          end: Matrix4.identity(),
        ).animate(controller.resetAnimation);

        animationReset.addListener(() {
          controller.transCtrl.value.value = animationReset.value;
        });

        controller.resetAnimation.reset();
        controller.resetAnimation.forward();
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add),
    );
  }
}
