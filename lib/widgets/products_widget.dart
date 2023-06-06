import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/services/utils.dart';

class ProductWidget extends StatefulWidget {
  ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width / 2,
          height: size.height / 4,
          child: Card(
            elevation: 1,
            color: Utils(context).isDark
                ? Colors.grey[800]
                : Colors.lightBlueAccent.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 5,
          child: PopupMenuButton(
            tooltip: "options",
            splashRadius: 3,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {},
                  value: 1,
                  child: const Text("Edit"),
                ),
                PopupMenuItem(
                  textStyle: const TextStyle(color: Colors.redAccent),
                  onTap: () {},
                  child: const Text("Delete"),
                )
              ];
            },
          ),
        ),
        Positioned(
          top: 10,
          left: 5,
          child: SizedBox()
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product",
                style: kTextStyle(20, context),
              ),
              Text(
                "N10,000",
                style: kTextStyle(15, context),
              )
            ],
          ),
        )
      ],
    );
  }
}
