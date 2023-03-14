import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/categoryMap/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryMapPage extends GetView<CategoryMapController> {
  CategoryMapPage({super.key});

  static const pageName = "/categoryMap";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.white,
        child: Obx(
          () => InteractiveViewer(
            //boundaryMargin: const EdgeInsets.all(5),
            maxScale: 4,
            constrained: false,
            transformationController: controller.transCtrl.value,
            child: Image.asset(
              "assets/images/ekrankarti.jpg",
              fit: BoxFit.cover,
              width: 165.0.wp,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final animationReset = Matrix4Tween(
            begin: controller.transCtrl.value.value,
            end: Matrix4.identity(),
          ).animate(controller.ResetAnimation);

          animationReset.addListener(() {
            controller.transCtrl.value.value = animationReset.value;
          });

          controller.ResetAnimation.reset();
          controller.ResetAnimation.forward();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
