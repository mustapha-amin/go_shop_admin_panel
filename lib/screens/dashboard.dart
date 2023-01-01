import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/widgets/header.dart';
import 'package:go_shop_admin_panel/widgets/products_widget.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Header(),
            ProductWidget(
              imgPath: 'assets/images/offers/laptop.png',
            ),
          ],
        ),
      ),
    );
  }
}
