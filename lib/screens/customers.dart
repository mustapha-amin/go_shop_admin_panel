import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/model/customer.dart';
import 'package:go_shop_admin_panel/services/database.dart';
import 'package:sizer/sizer.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Customers",
          style: kTextStyle(18.sp, context),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Database.getCustomers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Customer> customers = snapshot.data!;
            return customers.isEmpty
                ? Center(
                    child: Text(
                      "No customer yet",
                      style: kTextStyle(18, context),
                    ),
                  )
                : ListView.builder(
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                          ),
                        ),
                        title: Text(customers[index].name!),
                      );
                    },
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
