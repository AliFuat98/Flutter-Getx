import 'package:first_app/app/core/utils/dataHelper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await DataHelper.init();
    print("Database has been created!");
  }
}
