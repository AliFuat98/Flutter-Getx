import 'package:first_app/app/core/utils/DataHelper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/models/Word.dart';

class HomeController extends GetxController {
  @override
  void onInit() async{
    super.onInit();
    await DataHelper.init();
    print("Database has been created!");
  }
}
