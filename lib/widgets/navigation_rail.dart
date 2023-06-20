import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/screens/add_category.dart';
import 'package:sizer/sizer.dart';
import '../consts/nav_rail_items.dart';
import '../screens/add_product.dart';
import '../screens/customers.dart';
import '../screens/orders_page.dart';
import '../screens/dashboard.dart';
import '../screens/product_categories.dart';
class NavRailAndDashboard extends StatefulWidget {
  const NavRailAndDashboard({super.key});

  @override
  State<NavRailAndDashboard> createState() => _NavRailAndDashboardState();
}

class _NavRailAndDashboardState extends State<NavRailAndDashboard> {
  late int _selectedTabIndex;

  @override
  void initState() {
    _selectedTabIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          elevation: 1,
          child: NavigationRail(
            labelType: NavigationRailLabelType.selected,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            destinations: navRailItems,
            selectedIndex: _selectedTabIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
        ),
        Container(
          height: size.height,
          width: 5.w,
          color: Colors.grey[700],
        ),
        Expanded(
          flex: 2,
          child: switch (_selectedTabIndex) {
            0 => const DashBoard(),
            1 => const CustomersScreen(),
            2 => const ProductCategories(),
            3 => const OrdersScreen(),
            4 => const AddCategory(),
            _ => const AddProduct()
          },
        ),
      ],
    );
  }
}
