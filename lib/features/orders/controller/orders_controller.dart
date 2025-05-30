import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_shop_admin_panel/core/providers.dart';
import 'package:go_shop_admin_panel/features/customers/controller/customers_ctrl.dart';
import 'package:go_shop_admin_panel/features/orders/repository/order_repository.dart';
import 'package:go_shop_admin_panel/features/products/controllers/product_controller.dart';
import 'package:go_shop_admin_panel/model/order.dart';
import 'package:go_shop_admin_panel/model/user.dart';
import 'package:go_shop_admin_panel/model/product.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(firestore: firestore.FirebaseFirestore.instance);
});

final ordersProvider = FutureProvider<List<Order>>((ref) async {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return orderRepository.fetchOrders();
});

final ordersWithDetailsProvider =
    FutureProvider<List<(Order, GoShopUser?, List<Product?>)>>((ref) async {
      final orders = await ref.watch(ordersProvider.future);
      final customers = await ref.watch(fetchCustomersProvider.future);
      final products = await ref.watch(productNotifierProvider.future) ?? [];

      return orders.map((order) {
        final customer = customers.firstWhere(
          (customer) => customer.uid == order.userId,
          orElse: () =>
              GoShopUser(uid: '', email: '', name: '', phoneNumber: 0),
        );

        final orderProducts = order.items.map((item) {
          return products.firstWhere((product) => product.id == item.productID);
        }).toList();

        return (order, customer, orderProducts);
      }).toList();
    });

final orderStatsProvider =
    FutureProvider<({int uniqueCustomers, double totalIncome})>((ref) async {
      final orders = await ref.watch(ordersProvider.future);

      // Calculate unique customers
      final uniqueCustomerIds = orders.map((order) => order.userId).toSet();

      // Calculate total income
      final totalIncome = orders.fold<double>(
        0,
        (sum, order) => sum + order.totalAmount,
      );

      return (
        uniqueCustomers: uniqueCustomerIds.length,
        totalIncome: totalIncome,
      );
    });
