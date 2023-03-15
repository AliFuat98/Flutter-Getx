import 'package:first_app/app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ListenWordPage extends GetView<ListenwordController> {
  ListenWordPage({super.key});

  static const pageName = "/listenWord";

  @override
  Widget build(BuildContext context) {
    return backButton();
  }
  Widget backButton() {
    return Positioned(
      left: 4.0.wp,
      top: 4.0.wp,
      child: IconButton(
        icon: const Icon(
          Icons.backspace,
          size: 50,
          color: Colors.red,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
