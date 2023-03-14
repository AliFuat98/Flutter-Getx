import 'package:get/get.dart';

import 'controller.dart';

class CategoryMapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryMapController());
  }
}
