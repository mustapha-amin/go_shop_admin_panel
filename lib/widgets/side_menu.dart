import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/screens/add_category.dart';
import 'package:go_shop_admin_panel/screens/add_product.dart';
import 'package:go_shop_admin_panel/screens/customers.dart';
import 'package:go_shop_admin_panel/screens/featured.dart';
import 'package:go_shop_admin_panel/screens/main_screen.dart';
import 'package:go_shop_admin_panel/screens/product_categories.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/services/theme_prefs.dart';
import 'package:go_shop_admin_panel/utils/screensize.dart';
import 'package:go_shop_admin_panel/widgets/drawer_listtile.dart';
import 'package:sizer/sizer.dart';

import '../screens/orders_page.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      width: 250,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          const DrawerHeader(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/general/admin.jpg'),
            ),
          ),
          const DrawerListTile(
            title: "Main",
            destination: MainScreen(),
            icon: Icons.home_filled,
          ),
          const DrawerListTile(
            title: "Customers",
            destination: CustomersScreen(),
            icon: Icons.account_circle,
          ),
          const DrawerListTile(
              title: "View products",
              destination: ProductCategories(),
              icon: Icons.store),
          const DrawerListTile(
            title: "Orders",
            destination: OrdersScreen(),
            icon: Icons.shopping_bag_rounded,
          ),
          const DrawerListTile(
            title: "Add category",
            destination: AddCategory(),
            icon: Icons.category_outlined,
          ),
          const DrawerListTile(
            title: "Featured",
            destination: FeaturedProducts(),
            icon: Icons.star,
          ),
          isPCorTablet(context)
              ? const DrawerListTile(
                  title: "Add products",
                  destination: AddProduct(),
                  icon: Icons.add,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
