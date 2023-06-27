import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/featured_product.dart';
import 'package:go_shop_admin_panel/model/product.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:sizer/sizer.dart';

import '../utils/screensize.dart';
import '../widgets/side_menu.dart';

class Feature extends StatefulWidget {
  Product? product;
  Feature({this.product, super.key});

  @override
  State<Feature> createState() => _FeatureState();
}

class _FeatureState extends State<Feature> {
  TextEditingController messageController = TextEditingController();
  final GlobalKey<ScaffoldState> featureProduct = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && featureProduct.currentState!.isDrawerOpen
          ? featureProduct.currentState!.openEndDrawer()
          : null;
    });
    return Scaffold(
      key: featureProduct,
      drawer: const SideMenu(),
      appBar: isPCorTablet(context)
          ? null
          : AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Database().featureProduct(
                      FeaturedProduct(
                        product: widget.product,
                        message: messageController.text,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.check),
                )
              ],
            ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                )),
                hintText: "Write something...",
              ),
              maxLength: 35,
            ),
          ],
        ),
      ),
    );
  }
}
