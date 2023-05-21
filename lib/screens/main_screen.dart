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
            : const Padding(
                padding: const EdgeInsets.all(8.0),
                child: DashBoard(),
              ),
      ),
    );
  }
}
