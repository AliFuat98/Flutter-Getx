import 'package:get/get.dart';
import 'controller.dart';

class GamesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GamesController());
  }
}
