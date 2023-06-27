import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/category.dart' as custom;
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/category_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../utils/screensize.dart';
import '../widgets/side_menu.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({super.key});

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  final GlobalKey<ScaffoldState> categoriesKey = GlobalKey();

  

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && categoriesKey.currentState!.isDrawerOpen
          ? categoriesKey.currentState!.openEndDrawer()
          : null;
    });
    var categories = Provider.of<List<custom.Category>>(context);

    return Scaffold(
      key: categoriesKey,
      drawer: const SideMenu(),
      appBar: isPCorTablet(context)
          ? null
          : AppBar(
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    });
              }),
              title: Text(
                "Categories",
                style: kTextStyle(18.sp, context),
              ),
              centerTitle: true,
            ),
      body: Row(
        children: [
          isPCorTablet(context) ? const SideMenu() : const SizedBox(),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryWidget(
                    category: categories[index],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
