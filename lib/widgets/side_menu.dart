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
      width: 80.w,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: const [
          DrawerHeader(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/general/admin.jpg'),
            ),
          ),
          DrawerListTile(
              title: "Main",
              destination: MainScreen(),
              icon: Icons.home_filled),
          DrawerListTile(
            title: "Customers",
            destination: CustomersScreen(),
            icon: Icons.account_circle,
          ),
          DrawerListTile(
              title: "View products",
              destination: ProductCategories(),
              icon: Icons.store),
          DrawerListTile(
            title: "Orders",
            destination: OrdersScreen(),
            icon: Icons.shopping_bag_rounded,
          ),
          DrawerListTile(
            title: "Add category",
            destination: AddCategory(),
            icon: Icons.category_outlined,
          ),
          DrawerListTile(
            title: "Featured",
            destination: FeaturedProducts(),
            icon: Icons.star,
          ),
          kIsWeb
              ? DrawerListTile(
                  title: "Add products",
                  destination: AddProduct(),
                  icon: Icons.add,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
