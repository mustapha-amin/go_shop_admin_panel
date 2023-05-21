import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/widgets/products_widget.dart';

import '../global_products.dart';
import '../services/utils.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Utils(context).color,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: GridView.builder(
          itemCount: GlobalProducts.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 3,
          ),
          itemBuilder: (context, index) {
            return ProductWidget(
                imgPath: GlobalProducts.products[index].imgPath!);
          },
        ),
      ),
    );
  }
}
