import 'package:get/get.dart';
import 'controller.dart';

class StoreBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController());
  }
}
