import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/controllers/menu_controller.dart';
import 'package:go_shop_admin_panel/screens/dashboard.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return DashBoard();
  }
}
