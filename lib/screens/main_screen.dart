import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/controllers/menu_controller.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/screens/dashboard.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: context.read<MenuContoller>().getScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Responsive.isDesktop(context)
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * .25,
                    child: SideMenu(),
                  ),
                  Container(
                    width: size.width * .75,
                    child: DashBoard(),
                  )
                ],
              )
            : DashBoard(),
      ),
    );
  }
}
