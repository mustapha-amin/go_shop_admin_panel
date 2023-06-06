import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/category_widget.dart';
import 'package:sizer/sizer.dart';

class ProductCategories extends StatefulWidget {
  const ProductCategories({super.key});

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  @override
  Widget build(BuildContext context) {
    Database database = Database();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: kTextStyle(18.sp, context),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: database.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Category> categories = snapshot.data!;
            return GridView.builder(
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
                });
          } else if (!snapshot.hasData) {
            return const Text("No category added yet");
          }
          return const Center(
            child: Text("No category added yet"),
          );
        },
      ),
    );
  }
}
