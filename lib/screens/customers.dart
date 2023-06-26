import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/customer.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:go_shop_admin_panel/widgets/loading_widget.dart';
import 'package:go_shop_admin_panel/widgets/side_menu.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    var customers = Provider.of<List<Customer>?>(context);
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
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
      body: customers == null
          ? const LoadingWidget()
          : customers.isEmpty
              ? const Center(
                  child: Text("No customers"),
                )
              : ListView.builder(
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
    );
  }
}
