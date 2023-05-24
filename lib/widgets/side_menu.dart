import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/providers/theme_provider.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/screens/orders_page.dart';
import 'package:go_shop_admin_panel/screens/product_categories.dart';
import 'package:go_shop_admin_panel/services/theme_prefs.dart';
import 'package:go_shop_admin_panel/widgets/drawer_listtile.dart';
import 'package:provider/provider.dart';

import '../consts/textstyle.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    bool switchValue = ThemeSettings.getTheme();
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          const DrawerHeader(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/general/admin.jpg'),
            ),
          ),
          DrawerListTile(title: "Main", press: () {}, icon: Icons.home_filled),
          DrawerListTile(
            title: "Customers",
            press: () {},
            icon: Icons.account_circle,
          ),
          DrawerListTile(
              title: "View products",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAllProducts(),
                  ),
                );
              },
              icon: Icons.store),
          DrawerListTile(
            title: "Orders",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const OrdersScreen();
              }));
            },
            icon: Icons.shopping_bag_rounded,
          ),
          Responsive.isPC(context)
              ? DrawerListTile(
                  title: "Add products",
                  press: () {},
                  icon: Icons.add,
                )
              : const SizedBox(),
          ListTile(
            leading: Icon(switchValue ? Icons.dark_mode : Icons.light_mode),
            title: Text(
              switchValue ? "Dark mode" : "light mode",
              style: kTextStyle(17, context),
            ),
            trailing: Switch(
                value: switchValue,
                onChanged: (val) {
                  setState(() {
                    context.read<ThemeProvider>().toggleTheme();
                  });
                }),
          )
        ],
      ),
    );
  }
}
