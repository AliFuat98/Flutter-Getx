import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddWord extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeController.fromKey,
        child: ListView(
          children: [
            // Close And Done Buttons
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CLOSE BUTTON
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.editController.clear();
                      homeController.changeSelectedCategory(null);
                    },
                    icon: const Icon(Icons.close),
                  ),

                  // DONE BUTTON
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      if (!homeController.fromKey.currentState!.validate()) {
                        return;
                      }
                      if (homeController.selectedCategory.value == null) {
                        EasyLoading.showError("Please select a category");
                        return;
                      }
                      var success = homeController.updateCategory(
                        homeController.selectedCategory.value!,
                        homeController.editController.text,
                      );
                      if (success) {
                        EasyLoading.showSuccess(
                          "Word is added to the category",
                        );
                        Get.back();
                        homeController.changeSelectedCategory(null);
                      } else {
                        EasyLoading.showError("word is already exist");
                      }
                      homeController.editController.clear();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 14.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // NEW WORD title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "New Word",
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Word text input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeController.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your word";
                  }
                  return null;
                },
              ),
            ),

            // Add to Text
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                "Add to",
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),

            // list of categories
            ...homeController.categories
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () =>
                            homeController.changeSelectedCategory(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ICON AND TITLE
                              Row(
                                children: [
                                  Icon(
                                    IconData(
                                      element.icon,
                                      fontFamily: "MaterialIcons",
                                    ),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(width: 3.0.wp),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              // CHECK TICK
                              if (homeController.selectedCategory.value ==
                                  element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
