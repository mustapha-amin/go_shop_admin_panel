import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/controllers/menu_controller.dart';
import 'package:go_shop_admin_panel/model/category.dart' as k;
import 'package:go_shop_admin_panel/model/customer.dart';
import 'package:go_shop_admin_panel/screens/main_screen.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '/services/theme_prefs.dart';
import '/theme/theme.dart';
import 'model/order.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeSettings().init();
  kIsWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyD5zcoRfa-Cy8IrM4M5mijPchvP-PqIdK4",
              authDomain: "go-shop-3d5ba.firebaseapp.com",
              projectId: "go-shop-3d5ba",
              storageBucket: "go-shop-3d5ba.appspot.com",
              messagingSenderId: "504738923921",
              appId: "1:504738923921:web:93feaa5878475bac4dc630",
              measurementId: "G-87M2NPT5RT"))
      : await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider(
      //   create: (_) => MenuContoller(),
      // ),
      StreamProvider<List<k.Category>>.value(
        value: Database.getCategories(),
        initialData: [],
      ),
      StreamProvider<List<Order>?>.value(
        value: Database().fetchOrders(),
        initialData: [],
      ),
      StreamProvider<List<Customer>?>.value(
        value: Database.getCustomers(),
        initialData: [],
      )
    ],
    child: Sizer(
      builder: (context, _, __) {
        return MaterialApp(
          home: const MyApp(),
          debugShowCheckedModeBanner: false,
          theme: MyTheme.themeData(context),
        );
      },
    ),
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
