import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/model/featured_product.dart';
import 'package:go_shop_admin_panel/widgets/products_widget.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';

import '../utils/screensize.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  late Stream<List<FeaturedProduct>> featured;
  final GlobalKey<ScaffoldState> featuredProductsKey = GlobalKey();

  @override
  void initState() {
    featured = Database().getFeaturedProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && featuredProductsKey.currentState!.isDrawerOpen
          ? featuredProductsKey.currentState!.openEndDrawer()
          : null;
    });
    return Scaffold(
      key: featuredProductsKey,
      drawer: SideMenu(),
      appBar: isPC(context)
          ? null
          : AppBar(
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              }),
              title: const Text("Featured"),
              centerTitle: true,
            ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isPC(context) ? SideMenu() : SizedBox(),
          StreamBuilder(
            stream: featured,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isPCorTablet(context) ? 4 : 2,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductWidget(
                          product: snapshot.data![index].product,
                          featured: true,
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
