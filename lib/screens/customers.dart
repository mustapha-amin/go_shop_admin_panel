import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/customer.dart';
import 'package:go_shop_admin_panel/widgets/loading_widget.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';

import '../utils/screensize.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final GlobalKey<ScaffoldState> customerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPCorTablet(context) && customerKey.currentState!.isDrawerOpen
          ? customerKey.currentState!.openEndDrawer()
          : null;
    });
    var customers = Provider.of<List<Customer>?>(context);
    return Scaffold(
      key: customerKey,
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
                "Customers",
                style: kTextStyle(18, context),
              ),
              foregroundColor: Colors.black,
              centerTitle: true,
            ),
      body: Row(
        children: [
          isPCorTablet(context)
              ? const SizedBox(
                  child: SideMenu(),
                )
              : const SizedBox(),
          customers == null
              ? const LoadingWidget()
              : customers.isEmpty
                  ? const Center(
                      child: Text("No customers"),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              child: Icon(
                                Icons.person_2_outlined,
                              ),
                            ),
                            title: Text(customers[index].name!),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
