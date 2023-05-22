import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/modules/category/view.dart';
import 'package:first_app/app/modules/category_map/view.dart';
import 'package:first_app/app/modules/games/view.dart';
import 'package:first_app/app/modules/home/widgets/menuitem.dart';
import 'package:first_app/app/modules/store/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  static const pageName = "/homepage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            getBackgroundImage(),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      //color: Color.fromARGB(255, 174, 230, 247),
                      color: Color.fromARGB(255, 51, 184, 224),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 25, 113, 139),
                          blurRadius: 5,
                        )
                      ]),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "hi Yavız",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 242, 253, 240),
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        textColor: Colors.white,
                        subtitle: Text(
                          "naber",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 15.0.sp,
                          ),
                        ),
                        trailing: const CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              "assets/images/word_images/family/mummy.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: Center(
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisSpacing: 5,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: const [
                          MenuItem(
                            pageName: CategoryMapPage.pageName,
                            menuItemName: "Learn",
                            iconData: Icons.landscape_rounded,
                          ),
                          MenuItem(
                            pageName: CategoryPage.pageName,
                            menuItemName: "Admin",
                            iconData: Icons.admin_panel_settings_outlined,
                          ),
                          MenuItem(
                            pageName: GamesPage.pageName,
                            menuItemName: "Games",
                            iconData: Icons.games_outlined,
                          ),
                          MenuItem(
                            pageName: StorePage.pageName,
                            menuItemName: "Store",
                            iconData: Icons.store_mall_directory_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //SizedBox(height: ,)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/menu_background.jpg"),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
        ),
      ),
    );
  }
}
