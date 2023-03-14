import 'package:first_app/app/data/services/storage/services.dart';
import 'package:first_app/app/modules/category/binding.dart';
import 'package:first_app/app/modules/category/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'app/modules/categoryMap/binding.dart';
import 'app/modules/categoryMap/view.dart';

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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: CategoryPage(),
      initialBinding: CategoryBinding(),
      getPages: [
        GetPage(
          name: "/",
          page: () => CategoryPage(),
          binding: CategoryBinding(),
        ),
        GetPage(
          name: CategoryMapPage.pageName,
          page: () => CategoryMapPage(),
          binding: CategoryMapBinding(),
        ),
      ],
      builder: EasyLoading.init(),
    );
  }
}
