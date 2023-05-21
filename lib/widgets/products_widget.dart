import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/services/utils.dart';

class ProductWidget extends StatefulWidget {
  String imgPath;
  ProductWidget({super.key, required this.imgPath});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 2.5,
      height: size.height / 4,
      child: Card(
        elevation: 1,
        color: Utils(context).isDark
            ? Colors.grey[700]
            : Colors.lightBlueAccent.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    widget.imgPath,
                    fit: BoxFit.cover,
                    height: size.height / 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "title",
                        style: kTextStyle(20, context),
                      ),
                      Text(
                        "N10, 000",
                        style: kTextStyle(15, context),
                      ),
                    ],
                  )
                ],
              ),
            ),
            PopupMenuButton(
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
            )
          ],
        ),
      ),
    );
  }
}
