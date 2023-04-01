import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Game3Page extends GetView<Game3Controller> {
  Game3Page({super.key});

  static const pageName = "/game3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(title: const Text(pageName)),
        body: SafeArea(
          child: Center(
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
          ),
        ));
  }
}
