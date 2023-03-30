import 'package:first_app/app/core/utils/extensions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String pageName;
  final String menuItemName;

  const MenuItem({
    super.key,
    required this.pageName,
    required this.menuItemName,
  });

  @override
  Widget build(BuildContext context) {
    var squareWith = Get.width - 8.0.wp;
    return GestureDetector(
      onTap: () {
        Get.toNamed(pageName);
      },
      child: Container(
        width: squareWith / 2,
        height: squareWith / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.amber[100],
          boxShadow: [
            BoxShadow(
              color: Colors.amber[50]!,
              blurRadius: 9,
              offset: const Offset(3, 9),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              menuItemName,
              style: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
