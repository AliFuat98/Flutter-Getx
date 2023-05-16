import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/listen_word/view.dart';
import 'package:first_app/app/modules/category_map/controller.dart';
import 'package:first_app/app/widgets/positions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../category/controller.dart';

class CategoryMapPage extends GetView<CategoryMapController> {
  CategoryMapPage({super.key});

  static const pageName = "/categoryMap";

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    var positionList = getPositions();
    var index = -1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => Stack(children: [
          InteractiveViewer(
            maxScale: 10,
            constrained: false,
            transformationController: controller.transCtrl.value,
            child: Stack(children: [
              Image.asset(
                "assets/images/map.jpg",
                width: 1500,
              ),
              ...categoryController.categories.map((element) {
                index++;
                // fazla category olduğunda hata vermemesi için ilerde silinebilir
                if (index == positionList.length) {
                  index = positionList.length - 1;
                }
                return Positioned(
                  left: positionList[index].leftPosition,
                  top: positionList[index].topPosition,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(ListenWordPage.pageName, arguments: element);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(element.pictureSrc),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1.5)),
                    ),
                  ),
                );
              }).toList(),
            ]),
          ),
          backButton(),
        ]),
      ),
      floatingActionButton: resetScaleButton(),
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