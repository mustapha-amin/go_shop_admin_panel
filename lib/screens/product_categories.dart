import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/global_products.dart';
import 'package:go_shop_admin_panel/services/utils.dart';
import 'package:go_shop_admin_panel/widgets/category_widget.dart';

import '../widgets/products_widget.dart';
import 'products.dart';

class ViewAllProducts extends StatefulWidget {
  const ViewAllProducts({super.key});

  @override
  State<ViewAllProducts> createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Utils(context).color,
        elevation: 0,
      ),
      body: GridView.builder(
        itemCount: GlobalProducts.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductsPage()));
            },
            child: CategoryWidget(
              category: GlobalProducts.categories[index],
            ),
          );
        },
      ),
    );
  }
}
