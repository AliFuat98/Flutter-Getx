import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:first_app/app/modules/home/controller.dart';
import 'package:first_app/app/modules/home/widgets/add_card.dart';
import 'package:first_app/app/modules/home/widgets/add_word.dart';
import 'package:first_app/app/modules/home/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            title(),
            categoriesAndAddCategoryCard(),
          ],
        ),
      ),
      floatingActionButton: deleteCategoryAndAddWordButton(),
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.all(4.0.wp),
      child: Text(
        "My Categories",
        style: TextStyle(
          fontSize: 24.0.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget categoriesAndAddCategoryCard() {
    return Obx(
      () => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...controller.categories
              .map((element) => LongPressDraggable(
                    data: element,
                    onDragStarted: () => controller.changeDeleting(true),
                    onDraggableCanceled: (velocity, offset) =>
                        controller.changeDeleting(false),
                    onDragEnd: (details) => controller.changeDeleting(false),
                    feedback: Opacity(
                      opacity: 0.8,
                      child: CategoryCard(category: element),
                    ),
                    child: CategoryCard(category: element),
                  ))
              .toList(),
          AddCategoryCard(),
        ],
      ),
    );
  }

  Widget deleteCategoryAndAddWordButton() {
    return DragTarget<Category>(
      builder: (context, candidateData, rejectedData) => Obx(
        () => FloatingActionButton(
          onPressed: () {
            if (controller.categories.isEmpty) {
              EasyLoading.showInfo("Create a Category to add a word");
              return;
            }
            Get.to(
              () => AddWord(),
              transition: Transition.downToUp,
            );
          },
          backgroundColor: controller.deleting.value ? Colors.red : Colors.blue,
          child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
        ),
      ),
      onAccept: (category) {
        controller.deleteCategory(category);
        EasyLoading.showSuccess("Delete Success");
      },
    );
  }
}
