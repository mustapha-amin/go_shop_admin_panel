import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/products_widget.dart';
import 'package:sizer/sizer.dart';
import '../model/product.dart';
import '../utils/screensize.dart';
import '../widgets/side_menu.dart';

class Products extends StatefulWidget {
  String? categoryId;
  Products({this.categoryId, super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> productsKey = GlobalKey();
 
  
  
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && productsKey.currentState!.isDrawerOpen
          ? productsKey.currentState!.openEndDrawer()
          : null;
    });
    return Scaffold(
      drawer: const SideMenu(),
      key: productsKey,
      appBar: isPCorTablet(context)
          ? null
          : AppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      productsKey.currentState!.openDrawer();
                    },
                  );
                },
              ),
            ),
      body: Row(
        children: [
          isPCorTablet(context)
              ? const SizedBox(
                  child: SideMenu(),
                )
              : const SizedBox(),
          Expanded(
            child: StreamBuilder(
              stream: Database.getproducts(widget.categoryId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data!;
                  return products.isNotEmpty
                      ? GridView.builder(
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
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
          ),
        ],
      ),
    );
  }
}
