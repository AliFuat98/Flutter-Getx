import 'package:first_app/app/data/providers/content/provider.dart';
import 'package:first_app/app/data/services/content/content_repository.dart';
import 'package:get/get.dart';
import 'controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        contentRepository: ContentRepository(
          contentProvider: ContentProvider(),
        ),
      ),
    );
  }
}
