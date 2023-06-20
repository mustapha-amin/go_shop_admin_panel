import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData themeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey[100],
      primaryColor: Colors.green,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
      ),
      navigationRailTheme: NavigationRailThemeData(
        useIndicator: true,
        indicatorShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        labelType: NavigationRailLabelType.all,
        selectedLabelTextStyle: TextStyle(
          color: Colors.black,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: Colors.grey[700],
        ),
        elevation: 3,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 53, 70, 251),
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
      ),
    );
  }
}
