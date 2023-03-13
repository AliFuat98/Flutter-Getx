import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:first_app/app/modules/word/widgets/doing_word_list.dart';
import 'package:first_app/app/modules/word/widgets/done_word_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class WordPage extends StatelessWidget {
  WordPage({super.key});

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    var category = categoryController.selectedCategory.value!;
    var color = HexColor.fromHex(category.color);

    return Scaffold(
      body: Form(
        key: categoryController.fromKey,
        child: ListView(
          children: [
            backButton(),
            categoryIconAndName(color, category),
            getTotalDoneWordProgress(color),
            wordNameTextField(),
            DoingWordList(),
            DoneWordList(),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return Padding(
      padding: EdgeInsets.all(3.0.wp),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
              categoryController.updateWords();
              categoryController.changeSelectedCategory(null);
              categoryController.editController.clear();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryIconAndName(Color color, dynamic category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
      child: Row(
        children: [
          Icon(
            IconData(category.icon, fontFamily: "MaterialIcons"),
            color: color,
          ),
          SizedBox(width: 3.0.wp),
          Text(
            category.title,
            style: TextStyle(
              fontSize: 12.0.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget getTotalDoneWordProgress(Color color) {
    return Obx(() {
      var totalWords = categoryController.doingWords.length +
          categoryController.doneWords.length;
      return Padding(
        padding: EdgeInsets.only(
          left: 16.0.wp,
          top: 3.0.wp,
          right: 16.0.wp,
        ),
        child: Row(
          children: [
            Text(
              "$totalWords words",
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 3.0.wp),
            Expanded(
              child: StepProgressIndicator(
                // 0 total step hata vermesin die
                totalSteps: totalWords == 0 ? 1 : totalWords,
                currentStep: categoryController.doneWords.length,
                size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color],
                ),
                unselectedColor: Colors.grey[300]!,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget wordNameTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
      child: TextFormField(
        controller: categoryController.editController,
        autofocus: true,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          prefixIcon: Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey[400],
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (categoryController.fromKey.currentState!.validate()) {
                var success = categoryController
                    .addWord(categoryController.editController.text);
                if (success) {
                  EasyLoading.showSuccess("words is added");
                } else {
                  EasyLoading.showError("word couldn't be added");
                }
                categoryController.editController.clear();
              }
            },
            icon: const Icon(Icons.done),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Please enter your word";
          }
          return null;
        },
      ),
    );
  }
}
