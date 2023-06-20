import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/services/utils.dart';

import '../model/order.dart';

class OrderWidget extends StatelessWidget {
  Order order;
  OrderWidget({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:   Colors.white10,
          ),
          child: ListTile(
            title: Text(order.name!),
            subtitle: Text("Order ID: ${order.orderId}"),
            trailing: Text(order.status! ? 'Pending' : 'Delivered'),
          ),
        ),
      ),
    );
  }
}
