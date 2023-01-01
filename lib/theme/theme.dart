import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData themeData(BuildContext context, bool isDark) {
    return ThemeData(
      scaffoldBackgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      primaryColor: Colors.green,
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
    );
  }
}
