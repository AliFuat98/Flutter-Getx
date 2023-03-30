import 'package:first_app/app/data/services/storage/services.dart';

import 'package:first_app/app/modules/ListenWord/binding.dart';
import 'package:first_app/app/modules/ListenWord/view.dart';
import 'package:first_app/app/modules/category/binding.dart';
import 'package:first_app/app/modules/category/view.dart';
import 'package:first_app/app/modules/categoryMap/binding.dart';
import 'package:first_app/app/modules/categoryMap/view.dart';
import 'package:first_app/app/modules/games/binding.dart';
import 'package:first_app/app/modules/games/view.dart';
import 'package:first_app/app/modules/home/binding.dart';
import 'package:first_app/app/modules/home/view.dart';
import 'package:first_app/app/modules/store/binding.dart';
import 'package:first_app/app/modules/store/view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'VELEDE BILGI AKTARIMI',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(
          name: CategoryPage.pageName,
          page: () => CategoryPage(),
          binding: CategoryBinding(),
        ),
        GetPage(
          name: CategoryMapPage.pageName,
          page: () => CategoryMapPage(),
          binding: CategoryMapBinding(),
        ),
        GetPage(
          name: ListenWordPage.pageName,
          page: () => ListenWordPage(),
          binding: ListenWordBinding(),
        ),
        GetPage(
          name: StorePage.pageName,
          page: () => StorePage(),
          binding: StoreBinding(),
        ),
        GetPage(
          name: GamesPage.pageName,
          page: () => GamesPage(),
          binding: GamesBinding(),
        ),
      ],
      builder: EasyLoading.init(),
    );
  }
}
