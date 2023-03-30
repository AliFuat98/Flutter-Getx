import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class StorePage extends GetView<StoreController> {
  StorePage({super.key});

  static const pageName = "/store";

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
