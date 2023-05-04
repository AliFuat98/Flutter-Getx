import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../word/view.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    super.key,
    required this.category,
  });

  final categoryController = Get.find<CategoryController>();
  final Category category;

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;
    const color = Colors.lightGreenAccent;

    return GestureDetector(
      onTap: () {
        categoryController.changeSelectedCategory(category);
        categoryController.changeWords(category.words);
        Get.to(() => WordPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getStepProcessor(color),
            getCategoryIcon(color),
            getCategoryCardInfo(),
          ],
        ),
      ),
    );
  }

  Widget getStepProcessor(Color color) {
    return StepProgressIndicator(
      totalSteps: 100,
      currentStep: 50,
      size: 5,
      padding: 0,
      selectedGradientColor: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.5),
            color,
          ]),
      unselectedGradientColor: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white]),
    );
  }

  Widget getCategoryCardInfo() {
    return Padding(
      padding: EdgeInsets.all(6.0.wp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 2.0.wp),
          Text(
            "${category.words.length} words",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget getCategoryIcon(Color color) {
    return Padding(
      padding: EdgeInsets.all(6.0.wp),
      child: Icon(
        IconData(
          const Icon(Icons.abc_sharp) as int,
          fontFamily: "MaterialIcons",
        ),
        color: color,
      ),
    );
  }
}
