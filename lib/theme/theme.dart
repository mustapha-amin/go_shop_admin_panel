import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/services/utils.dart';

class MyTheme {
  static ThemeData themeData(BuildContext context, bool isDark) {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      primaryColor: Colors.green,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      listTileTheme: ListTileThemeData(
        textColor: isDark ? Colors.white : Colors.black,
        iconColor: isDark ? Colors.white : Colors.black,
      ),
      dividerTheme: DividerThemeData(
        thickness: 1,
        color: isDark ? Colors.grey : Colors.black,
      ),
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : Colors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
        foregroundColor: Utils(context).color,
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
          color: Utils(context).color,
        ),
        unselectedLabelTextStyle: TextStyle(
          color: Utils(context).isDark ? Colors.grey : Colors.grey[700],
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
