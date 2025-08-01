import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/extensions.dart';
import 'package:go_shop_admin_panel/features/customers/views/cutomers.dart';
import 'package:go_shop_admin_panel/features/dashboard/widgets/drawer.dart';
import 'package:go_shop_admin_panel/features/home/views/home.dart';
import 'package:go_shop_admin_panel/features/orders/views/orders.dart';
import 'package:go_shop_admin_panel/features/products/views/add_products.dart';
import 'package:go_shop_admin_panel/features/products/views/inventory.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MediaQuery.of(context).size.width >= 750
              ? null
              : AppBar(backgroundColor: Colors.transparent, elevation: 0),
      drawer:
          MediaQuery.of(context).size.width >= 750 ? null : DashboardDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          Widget currentContent = switch (ref.watch(dashboardIndexProvider)) {
            0 => Home(),
            1 => Inventory(),
            2 => AddProducts(),
            3 => Customers(),
            _ => Orders(),
          };
          final isMobile = constraints.maxWidth < 750;
          if (!isMobile) {
            return Row(
              children: [
                DashboardDrawer(color: Colors.grey[200]!),
                Expanded(child: currentContent.padAll(10)),
              ],
            );
          }
          return currentContent;
        },
      ),
    );
  }
}
