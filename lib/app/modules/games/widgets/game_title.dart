import 'package:first_app/app/core/utils/extensions.dart';
import 'package:first_app/app/core/values/colors.dart';
import 'package:flutter/widgets.dart';

Widget getGameTitle(String title) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(4.0.wp),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 24.0.sp,
          fontWeight: FontWeight.w900,
          color: darkBlue100,
          shadows: const [
            Shadow(
              color: blue,
              offset: Offset(2, 3),
              blurRadius: 5,
            ),
          ],
          letterSpacing: 2.0.wp,
        ),
      ),
    ),
  );
}
