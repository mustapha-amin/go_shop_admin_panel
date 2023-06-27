import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/order.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:go_shop_admin_panel/widgets/order_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/screensize.dart';
import '../widgets/side_menu.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<ScaffoldState> ordersKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && ordersKey.currentState!.isDrawerOpen
          ? ordersKey.currentState!.openEndDrawer()
          : null;
    });
    var orders = Provider.of<List<Order>?>(context);
    return Scaffold(
      key: ordersKey,
      drawer: SideMenu(),
      appBar: isPCorTablet(context)
          ? null
          : AppBar(
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              }),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
      body: Row(
        children: [
          isPCorTablet(context) ? SideMenu() : SizedBox(),
          Expanded(
              child: ListView(
                  children: [...orders!.map((e) => OrderWidget(order: e))])),
        ],
      ),
    );
  }
}
