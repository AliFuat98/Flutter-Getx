import 'package:first_app/app/data/providers/game/provider.dart';
import 'package:first_app/app/data/providers/word/provider.dart';
import 'package:get/get.dart';
import 'package:first_app/app/data/providers/category/provider.dart';
import 'package:first_app/app/data/services/storage/repository.dart';
import 'package:first_app/app/modules/category/controller.dart';

import 'controller.dart';

class CategoryMapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryMapController());
    Get.lazyPut(() => CategoryController(
          categoryRepository: GeneralRepository(
            categoryProvider: CategoryProvider(),
            wordProvider: WordProvider(),
            gameProvider: GameProvider(),
          ),
        ));
  }
}
