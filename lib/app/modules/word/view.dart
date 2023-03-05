import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/home/controller.dart';
import 'package:first_app/app/modules/word/widgets/doing_word_list.dart';
import 'package:first_app/app/modules/word/widgets/done_word_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class WordPage extends StatelessWidget {
  WordPage({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    var category = homeController.selectedCategory.value!;
    var color = HexColor.fromHex(category.color);

    return Scaffold(
      body: Form(
        key: homeController.fromKey,
        child: ListView(
          children: [
            // Back Button
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.updateWords();
                      homeController.changeSelectedCategory(null);
                      homeController.editController.clear();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
              ),
            ),

            // words
            Padding(
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
            ),

            // total done
            Obx(() {
              var totalWords = homeController.doingWords.length +
                  homeController.doneWords.length;
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
                        currentStep: homeController.doneWords.length,
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
            }),

            // Text form Field
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeController.editController,
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
                      if (homeController.fromKey.currentState!.validate()) {
                        var success = homeController
                            .addWord(homeController.editController.text);
                        if (success) {
                          EasyLoading.showSuccess("words is added");
                        } else {
                          EasyLoading.showError("word couldn't be added");
                        }
                        homeController.editController.clear();
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
            ),

            // doing List
            DoingWordList(),
            DoneWordList(),
          ],
        ),
      ),
    );
  }
}
