import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/screens/feature_product.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/utils/consts.dart';
import 'package:go_shop_admin_panel/utils/extensions.dart';
import 'package:go_shop_admin_panel/utils/screensize.dart';
import 'package:sizer/sizer.dart';

import 'shimmer_widget.dart';

class ProductWidget extends StatefulWidget {
  Product? product;
  bool? featured;
  ProductWidget({this.product, this.featured, super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(5),
      width: isPCorTablet(context) ? 40.w : 50.w,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            color: Colors.grey.withOpacity(0.1),
            blurStyle: BlurStyle.solid,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 15.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.product!.imgPath!,
                        ),
                      ),
                    )),
                Text(
                  widget.product!.name!,
                  style: kTextStyle(15, context),
                ),
                Text(
                  '$nairaSymbol ${widget.product!.price!.toMoney}',
                  style: kTextStyle(20, context),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert_sharp,
            ),
            itemBuilder: (context) {
              return widget.featured!
                  ? [
                      PopupMenuItem(
                        child: const Text("Delete"),
                        onTap: () {
                          log(widget.product!.id.toString());
                          Future.delayed(Duration.zero, () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete product"),
                                    content: const Text(
                                        "Do you want to delete this product from your featured product list?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Database().removeFromFeatured(
                                              widget.product!.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No"),
                                      ),
                                    ],
                                  );
                                });
                          });
                        },
                      ),
                    ]
                  : [
                      const PopupMenuItem(
                        child: Text("Edit"),
                      ),
                      PopupMenuItem(
                        child: const Text("Delete"),
                        onTap: () {
                          log(widget.product!.id.toString());
                          Future.delayed(Duration.zero, () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete product"),
                                    content: const Text(
                                        "Do you want to delete this product?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Database()
                                              .deleteProduct(widget.product!);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No"),
                                      ),
                                    ],
                                  );
                                });
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: const Text("Feature"),
                        onTap: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Feature(
                                product: widget.product,
                              );
                            }));
                          });
                        },
                      )
                    ];
            },
          ),
        ],
      ),
    );
  }
}
