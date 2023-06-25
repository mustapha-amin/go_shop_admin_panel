import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/products_widget.dart';
import 'package:sizer/sizer.dart';
import '../model/product.dart';

class Products extends StatelessWidget {
  String? categoryId;
  Products({this.categoryId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryId!,
          style: kTextStyle(18.sp, context),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Database.getproducts(categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;
            return products.isNotEmpty
                ? GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2 ,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductWidget(
                          product: products[index],
                          featured: false,
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("No product added yet"),
                  );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


