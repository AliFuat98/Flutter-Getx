import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/category/view.dart';
import 'package:first_app/app/modules/categoryMap/view.dart';
import 'package:first_app/app/modules/games/view.dart';
import 'package:first_app/app/modules/home/widgets/menuitem.dart';
import 'package:first_app/app/modules/store/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  static const pageName = "/";
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "MAIN MENU",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //
            GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: const [
                MenuItem(
                  pageName: CategoryMapPage.pageName,
                  menuItemName: "Learn",
                ),
                MenuItem(
                  pageName: CategoryPage.pageName,
                  menuItemName: "Admin",
                ),
                MenuItem(
                  pageName: GamesPage.pageName,
                  menuItemName: "Games",
                ),
                MenuItem(
                  pageName: StorePage.pageName,
                  menuItemName: "Store",
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(4.0.wp),
        child: Container(
          height: 10.0.hp,
          width: double.infinity,
          color: Colors.amber[50],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/icons/Icon7.png",
                height: 20.0.wp,
                width: 20.0.wp,
              ),
              Image.asset(
                "assets/images/icons/Icon8.png",
                height: 20.0.wp,
                width: 20.0.wp,
              ),
              Image.asset(
                "assets/images/icons/Icon9.png",
                height: 20.0.wp,
                width: 20.0.wp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
