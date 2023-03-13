import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoneWordList extends StatelessWidget {
  DoneWordList({super.key});

  final categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => categoryController.doneWords.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              // completed
              completedWordText(),
              ...getList(),
            ],
          )
        : Container());
  }

  Widget completedWordText() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.0.wp,
        horizontal: 5.0.wp,
      ),
      child: Text(
        "Completed Words(${categoryController.doneWords.length})",
        style: TextStyle(
          fontSize: 14.0.sp,
          color: Colors.grey,
        ),
      ),
    );
  }

  List<Widget> getList() {
    return categoryController.doneWords
        .map((element) => Dismissible(
              key: ObjectKey(element),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                categoryController.deleteDoneWord(element);
              },
              background: Container(
                color: Colors.red.withOpacity(0.8),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 5.0.wp),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.0.wp,
                  horizontal: 9.0.wp,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(Icons.done),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                      child: Text(
                        element["title"],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
