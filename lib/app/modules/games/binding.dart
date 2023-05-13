import 'package:first_app/app/data/providers/category/provider.dart';
import 'package:first_app/app/data/providers/game/provider.dart';
import 'package:first_app/app/data/providers/word/provider.dart';
import 'package:first_app/app/data/services/storage/repository.dart';
import 'package:first_app/app/modules/category/controller.dart';
import 'package:get/get.dart';
import 'controller.dart';

class GamesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GamesController(
          gameRepository: GeneralRepository(
            categoryProvider: CategoryProvider(),
            wordProvider: WordProvider(),
            gameProvider: GameProvider(),
          ),
        ));
    Get.lazyPut(() => CategoryController(
          categoryRepository: GeneralRepository(
            categoryProvider: CategoryProvider(),
            wordProvider: WordProvider(),
            gameProvider: GameProvider(),
          ),
        ));
  }
}
