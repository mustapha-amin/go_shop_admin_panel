import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/customer.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../model/order.dart';

class OrderWidget extends StatelessWidget {
  Order order;
  OrderWidget({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    var customers = Provider.of<List<Customer>?>(context);
    Customer customer =
        customers!.firstWhere((element) => element.id == order.customerID);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 7,
        shadowColor: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white10,
          ),
          child: ListTile(
            leading: Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    order.imgUrl!,
                  ),
                ),
              ),
            ),
            title: Text('${order.productName!} (${order.quantity} qtys)'),
            subtitle: Text(
              DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                order.orderDate!,
              ),
            ),
            trailing: Text("By ${customer.name}"),
          ),
        ),
      ),
    );
  }
}
