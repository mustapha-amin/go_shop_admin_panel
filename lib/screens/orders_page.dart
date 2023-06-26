import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/order.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:go_shop_admin_panel/widgets/order_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widgets/side_menu.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<List<Order>?>(context);
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ListView(children: [...orders!.map((e) => OrderWidget(order: e))]),
    );
  }
}
