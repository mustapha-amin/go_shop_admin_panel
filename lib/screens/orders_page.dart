import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/order.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:go_shop_admin_panel/widgets/order_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      ),
      body: ListView(
        children: [
          ...List.generate(
            8,
            (index) => OrderWidget(
              order: Order(
                name: "Musty",
                status: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
