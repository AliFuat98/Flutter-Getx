import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddWord extends StatelessWidget {
  final categoryController = Get.find<CategoryController>();
  AddWord({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: categoryController.fromKey,
        child: ListView(
          children: [
            // Close And Done Buttons
            closeAndDoneButtons(),

            // NEW WORD title
            getTitle(),

            wordNameInputField(),
            textAddTo(),
            ...getListOfCategories(),
          ],
        ),
      ),
    );
  }

  Widget closeAndDoneButtons() {
    return Padding(
      padding: EdgeInsets.all(3.0.wp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // CLOSE BUTTON
          IconButton(
            onPressed: () {
              Get.back();
              categoryController.editController.clear();
              categoryController.changeSelectedCategory(null);
            },
            icon: const Icon(Icons.close),
          ),

          // DONE BUTTON
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              if (!categoryController.fromKey.currentState!.validate()) {
                return;
              }
              if (categoryController.selectedCategory.value == null) {
                EasyLoading.showError("Please select a category");
                return;
              }
              var success = categoryController.updateCategory(
                  categoryController.selectedCategory.value!,
                  categoryController.editController.text,
                  "",
                  "",
                  50);
              if (success) {
                EasyLoading.showSuccess(
                  "Word is added to the category",
                );
                Get.back();
                categoryController.changeSelectedCategory(null);
              } else {
                EasyLoading.showError("word is already exist");
              }
              categoryController.editController.clear();
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
    );
  }

  Widget getTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
      child: Text(
        "New Word",
        style: TextStyle(
          fontSize: 20.0.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget wordNameInputField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
      child: TextFormField(
        controller: categoryController.editController,
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
    );
  }

  Widget textAddTo() {
    return Padding(
      padding: EdgeInsets.only(
          top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
      child: Text(
        "Add to",
        style: TextStyle(
          fontSize: 14.0.sp,
          color: Colors.grey,
        ),
      ),
    );
  }

  List<Widget> getListOfCategories() {
    return categoryController.categories
        .map((element) => Obx(
              () => InkWell(
                onTap: () => categoryController.changeSelectedCategory(element),
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
                              const Icon(Icons.add) as int,
                              fontFamily: "MaterialIcons",
                            ),
                            color: Colors.black,
                          ),
                          SizedBox(width: 3.0.wp),
                          Text(
                            element.name,
                            style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // CHECK TICK
                      if (categoryController.selectedCategory.value == element)
                        const Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }
}
