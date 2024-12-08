import 'package:flutter/cupertino.dart';
import 'colors.dart';

CupertinoThemeData get theme {
  return const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.blue1,
      textTheme: CupertinoTextThemeData(
          tabLabelTextStyle: TextStyle(fontFamily: "Fustat", fontSize: 12, color: AppColors.blue1),
          textStyle: TextStyle(
            fontFamily: "Fustat",
            fontSize: 24,
          )));
}
