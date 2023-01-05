import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/widgets/header.dart';
import 'package:go_shop_admin_panel/widgets/products_widget.dart';

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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Header(),
            Text("Latest products", style: kTextStyle(20, context)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Utils(context).isDark
                          ? Colors.blue[900]
                          : Colors.blue,
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.picture_in_picture),
                    label: Text("View all"),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Utils(context).isDark
                          ? Colors.blue[900]
                          : Colors.blue,
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.add_a_photo),
                    label: Text("Add new"),
                  ),
                ],
              ),
            ),
            ProductWidget(
              imgPath: 'assets/images/offers/laptop.png',
            ),
          ],
        ),
      ),
    );
  }
}
