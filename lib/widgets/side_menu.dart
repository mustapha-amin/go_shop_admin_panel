import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/providers/theme_provider.dart';
import 'package:go_shop_admin_panel/services/theme_prefs.dart';
import 'package:go_shop_admin_panel/widgets/drawer_listtile.dart';
import 'package:provider/provider.dart';

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
              title: "View all products", press: () {}, icon: Icons.store),
          DrawerListTile(
            title: "View orders",
            press: () {},
            icon: Icons.shopping_bag_rounded,
          ),
          ListTile(
            leading: Icon(switchValue ? Icons.dark_mode : Icons.light_mode),
            title: Text(switchValue ? "Dark mode" : "light mode"),
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
