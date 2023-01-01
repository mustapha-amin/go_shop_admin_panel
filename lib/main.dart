import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/controllers/menu_controller.dart';
import 'package:go_shop_admin_panel/screens/dashboard.dart';
import 'package:go_shop_admin_panel/screens/main_screen.dart';
import 'package:provider/provider.dart';
import '/services/theme_prefs.dart';
import '/theme/theme.dart';
import '/providers/theme_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeSettings().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
       ChangeNotifierProvider(
        create: (_) => MenuContoller(),
      ),
    ],
    child: Builder(builder: (context) {
      bool themeStatus = Provider.of<ThemeProvider>(context).themeStatus;
      return MaterialApp(
        home: const MyApp(),
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeData(context, themeStatus),
      );
    }),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
