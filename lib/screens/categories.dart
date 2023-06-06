import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/category_widget.dart';

class ViewCategories extends StatefulWidget {
  const ViewCategories({super.key});

  @override
  State<ViewCategories> createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  @override
  Widget build(BuildContext context) {
    Database database = Database();
    return Scaffold(
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
