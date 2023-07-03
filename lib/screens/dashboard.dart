import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/category.dart' as custom;
import 'package:go_shop_admin_panel/screens/add_product.dart';
import 'package:go_shop_admin_panel/utils/consts.dart';
import 'package:go_shop_admin_panel/utils/screensize.dart';
import 'package:go_shop_admin_panel/utils/snackbar.dart';
import 'package:go_shop_admin_panel/widgets/charts.dart';
import 'package:go_shop_admin_panel/widgets/sales.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:go_shop_admin_panel/widgets/spacings.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../widgets/pie_chart.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> dashboardKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && dashboardKey.currentState!.isDrawerOpen
          ? dashboardKey.currentState!.openEndDrawer()
          : null;
    });
    var categories = Provider.of<List<custom.Category>>(context);
    return Scaffold(
      key: dashboardKey,
      appBar: isPC(context)
          ? null
          : AppBar(
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isPC(context) ? const SideMenu() : const SizedBox(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          height: 30.h,
                          width: !isPCorTablet(context) ? 90.w : 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[100]!,
                                blurRadius: 0.5,
                              ),
                              BoxShadow(
                                color: Colors.grey[100]!,
                                blurRadius: 0.5,
                              )
                            ],
                          ),
                          child: const SalesWidget(),
                        ),
                      ),
                      isPCorTablet(context)
                          ? const Expanded(child: PieChartWidget())
                          : const SizedBox(),
                    ],
                  ),
                  !isPCorTablet(context)
                      ? const Expanded(child: PieChartWidget())
                      : const SizedBox(),
                  addVerticalSpacing(30),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Chart(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: !kIsWeb
          ? FloatingActionButton(
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
            )
          : null,
    );
  }
}
