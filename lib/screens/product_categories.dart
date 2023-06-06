import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/category_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({super.key});

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<List<Category>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: kTextStyle(18.sp, context),
        ),
        centerTitle: true,
      ),
      body: categories.isEmpty
          ? Center(
              child: Text(
                "No categories added",
                style: kTextStyle(19, context),
              ),
            )
          : GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
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
    );
  }
}
