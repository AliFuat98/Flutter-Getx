import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoingWordList extends StatelessWidget {
  DoingWordList({super.key});

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => categoryController.doingWords.isEmpty &&
            categoryController.doneWords.isEmpty
        ? emptyCategory()
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...getList(),
              if (categoryController.doingWords.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: const Divider(thickness: 2),
                ),
            ],
          ));
  }

  Widget emptyCategory() {
    return Column(
      children: [
        Image.asset(
          "assets/images/ekrankarti.jpg",
          fit: BoxFit.cover,
          width: 65.0.wp,
        ),
        Text(
          "Add a word",
          style: TextStyle(
            fontSize: 16.0.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  List<Widget> getList() {
    return categoryController.doingWords
        .map(
          (element) => Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 9.0.wp),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    onChanged: (value) {
                      categoryController.doneWord(element["title"]);
                    },
                    value: element["done"],
                    fillColor:
                        MaterialStateColor.resolveWith((states) => Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                  child: Text(
                    element["title"],
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        )
        .toList();
  }
}
