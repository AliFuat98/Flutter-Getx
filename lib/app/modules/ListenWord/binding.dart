import 'package:get/get.dart';

import 'controller.dart';

class ListenWordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListenwordController());
  }
}