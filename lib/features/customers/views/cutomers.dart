import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/consts/textstyle.dart';
import 'package:go_shop_admin_panel/features/customers/controller/customers_ctrl.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

class Customers extends ConsumerWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(fetchCustomersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: customers.when(
        data: (data) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Phone Number')),
              ],
              rows:
                  data.map((customer) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            customer.name ?? 'No Name',
                            style: kTextStyle(15),
                          ),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () async {
                              await UrlLauncherPlugin().launch(
                                'mailto:${customer.email}',
                              );
                            },
                            child: Text(
                              customer.email ?? 'No Email',
                              style: kTextStyle(15, color: Colors.blue),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            '0${customer.phoneNumber}' ?? 'No Phone',
                            style: kTextStyle(15),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          );
        },

        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
