import 'package:first_app/app/data/providers/category/provider.dart';
import 'package:first_app/app/data/services/storage/repository.dart';
import 'package:first_app/app/modules/home/controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        categoryRepository: CategoryRepository(
          categoryProvider: CategoryProvider(),
        ),
      ),
    );
  }
}
