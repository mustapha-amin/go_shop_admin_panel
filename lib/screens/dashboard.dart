import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/model/category.dart' as custom;
import 'package:go_shop_admin_panel/screens/add_product.dart';
import 'package:go_shop_admin_panel/utils/snackbar.dart';
import 'package:go_shop_admin_panel/widgets/header.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<List<custom.Category>>(context);
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: const SideMenu(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpacing(20),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            categories.isEmpty
                ? showSnackbar(context, "You haven't added a category yet")
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const AddProduct();
                    }),
                  );
          },
          tooltip: 'Add product',
          child: const Icon(Icons.add),
        ));
  }
}
