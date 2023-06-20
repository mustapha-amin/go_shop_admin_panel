import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/screens/feature_product.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import 'shimmer_widget.dart';

class ProductWidget extends StatefulWidget {
  Product? product;
  ProductWidget({this.product, super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 2,
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
      child: Stack(
        children: [
          Positioned(
            right: 1,
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert_sharp,
              ),
              itemBuilder: (context) {
                return [
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
                                      Database().deleteProduct(widget.product!);
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
          ),
          Image.network(widget.product!.imgPath!, height: 13.h,
              frameBuilder: (context, child, frame, _) {
            if (frame == null) {
              return ShimmerWidget(
                height: size.height / 7,
                width: size.width / 3,
              );
            }
            return child;
          }),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product!.name!,
                  style: kTextStyle(15, context),
                ),
                Text(
                  widget.product!.price!.toMoney,
                  style: kTextStyle(15, context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
