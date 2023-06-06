import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/controllers/menu_controller.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/screens/main_screen.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '/services/theme_prefs.dart';
import '/theme/theme.dart';
import '/providers/theme_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeSettings().init();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MenuContoller(),
      ),
      StreamProvider<List<Category>>.value(
        value: Database.getCategories(),
        initialData: [],
      ),
    ],
    child: Builder(builder: (context) {
      bool themeStatus = Provider.of<ThemeProvider>(context).themeStatus;
      return Sizer(
        builder: (context, _, __) {
          return MaterialApp(
            home: const MyApp(),
            debugShowCheckedModeBanner: false,
            theme: MyTheme.themeData(context, themeStatus),
          );
        },
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
