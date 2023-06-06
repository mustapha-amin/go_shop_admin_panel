import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/category.dart';
import 'package:go_shop_admin_panel/responsive.dart';
import 'package:go_shop_admin_panel/screens/add_product.dart';
import 'package:go_shop_admin_panel/utils/snackbar.dart';
import 'package:go_shop_admin_panel/widgets/header.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:provider/provider.dart';
import '../services/database.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<List<Category>>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Header(),
            addVerticalSpacing(20),
          ],
        ),
        floatingActionButton: Responsive.isMobile(context)
            ? FloatingActionButton(
                onPressed: () {
                  categories.isEmpty
                      ? showSnackbar(
                          context, "You haven't added a category yet")
                      : Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const AddProduct();
                          }),
                        );
                },
                tooltip: 'Add product',
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
