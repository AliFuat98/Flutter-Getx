import 'dart:math';

import 'package:first_app/app/data/models/content.dart';
import 'package:first_app/app/data/services/content/content_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ContentRepository contentRepository;
  HomeController({
    required this.contentRepository,
  });

  var availableContents = <Content>[];
  Rx<Content> selectedContent =
      Rx(Content(-1, "hiç", "assets/images/apple.png", true, true, 50, 3));

  @override
  void onInit() async {
    super.onInit();

    var contents = await contentRepository.readContents();
    // animation and avatar
    availableContents.assignAll(contents.where((cont) =>
        cont.inUsed == true &&
        (cont.category == 1 || cont.category == 5 || cont.category == 7)));

    choseContent();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("object");
  }

  void choseContent() {
    if (availableContents.isEmpty) {
      selectedContent.value =
          Content(-1, "hiç", "assets/images/apple.png", true, true, 50, 3);
      return;
    }
    Random random = Random();
    int index = random.nextInt(availableContents.length);
    var content = availableContents.elementAt(index);
    selectedContent.value = content;
  }
}
