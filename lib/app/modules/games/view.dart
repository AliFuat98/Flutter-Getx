import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class GamesPage extends GetView<GamesController> {
  GamesPage({super.key});

  static const pageName = "/games";

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
