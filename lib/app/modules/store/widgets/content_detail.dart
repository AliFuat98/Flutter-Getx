import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/core/values/colors.dart';
import 'package:first_app/app/modules/store/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentDetail extends StatelessWidget {
  ContentDetail({super.key});

  final controller = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brightBlue50,
      body: SafeArea(
          child: Column(
        children: [
          closeAndDoneButtons(),
          getWordImage(),
          SizedBox(height: 2.0.hp),
          getContentName(),
          if (controller.isContentPurchased(controller.selectedContent.value!))
            getUseButton(context),
        ],
      )),
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
            },
            icon: const Icon(Icons.close),
          ),

          // DONE BUTTON
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () async {
              Get.back();
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

  Widget getWordImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0.wp),
      width: 40.0.hp,
      height: 40.0.hp,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            controller.selectedContent.value?.pictureSrc ??
                "assets/images/game/mark.png",
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget getContentName() {
    return Text(
      controller.selectedContent.value?.name ?? "",
      style: TextStyle(
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget getUseButton(BuildContext context) {
    return Expanded(
      child: Center(
        child: ElevatedButton(
          onPressed: controller.isSelectedContentInUsed()
              ? () {
                  // unuse
                  controller.unUseSelectedContent();
                  Get.back();
                }
              : () {
                  // use
                  controller.useSelectedContent();
                  Get.back();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: controller.isSelectedContentInUsed()
                ? Colors.red
                : Colors.green,
            textStyle: const TextStyle(fontSize: 14.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5.0),
              Text(
                controller.isSelectedContentInUsed() ? "UNUSE" : "USE",
                style: TextStyle(
                  fontSize: 25.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
