import 'package:dotted_border/dotted_border.dart';
import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/core/values/colors.dart';
import 'package:first_app/app/data/models/category.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddCategoryCard extends StatelessWidget {
  AddCategoryCard({super.key});

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    var squareWith = Get.width - 12.0.wp;
    return Container(
      width: squareWith / 2,
      height: squareWith / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: "Fill Category",
              content: Form(
                key: categoryController.fromKey,
                child: Column(
                  children: [
                    categoryNameInputField(),
                    confirmButton(),
                  ],
                ),
              ));
          categoryController.editController.clear();
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(Icons.add, size: 10.0.wp, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget categoryNameInputField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
      child: TextFormField(
        controller: categoryController.editController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "CategoryName",
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Enter Your Category Name";
          }
          return null;
        },
      ),
    );
  }

  Widget confirmButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: yellow,
        //primary: blue, backroundla aynı sanırım
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(150, 40),
      ),
      child: const Text("confirm"),
      onPressed: () {
        if (categoryController.fromKey.currentState!.validate()) {
          // int icon = icons[categoryController.chipIndex.value].icon!.codePoint;
          // String color =
          //     icons[categoryController.chipIndex.value].color!.toHex();
          var category =
              Category.withoutSettings(categoryController.editController.text);
          Get.back();
          // categoryController.addCategory(category)
          //     ? EasyLoading.showSuccess("Create Success")
          //     : EasyLoading.showError("dublicate task");
        }
      },
    );
  }
}
