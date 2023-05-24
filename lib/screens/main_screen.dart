import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/controllers/menu_controller.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/screens/dashboard.dart';
import 'package:go_shop_admin_panel/widgets/navigation_rail.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: context.read<MenuContoller>().getScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Responsive.isPC(context)
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * .25,
                    child: const SideMenu(),
                  ),
                  SizedBox(
                    width: size.width * .75,
                    child: const DashBoard(),
                  )
                ],
              )
            : Responsive.isTablet(context)
                ? const NavRailAndDashboard()
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DashBoard(),
                  ),
      ),
    );
  }
}
