import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/screens/add_product.dart';
import 'package:go_shop_admin_panel/widgets/header.dart';
import 'package:go_shop_admin_panel/widgets/products_widget.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';

import '../services/utils.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(),
            addVerticalSpacing(20),
          ],
        ),
        floatingActionButton: Responsive.isMobile(context)
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddProduct();
                  }));
                },
                tooltip: 'Add product',
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
